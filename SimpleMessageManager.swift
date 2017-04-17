//
//  SimpleMessageManager.swift
//  Created by juan sanchez on 4/17/17.
//

import Foundation
import MultipeerConnectivity


protocol SimpleMessageManagerDelegate: class {
    func dataRecieved(_ data: Data, fromPeer senderPeer: MCPeerID)
    func peerFound(_ foundPeer: MCPeerID)
    func peerLost(_ lostPeer: MCPeerID)
}


class SimpleMessageManager: NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    fileprivate struct Constants {
        static let DEFAULT_SERVICE_TYPE = "simple-msg"
        static let DEFAULT_PEER_ID = UIDevice.current.name
    }
    fileprivate struct Keys {
        static let PEER_ID_KEY = "peer id"
    }
    
    var serviceType: String
    
    var myPeerID: MCPeerID
    
    var peerArray = [MCPeerID]() // MCPeerID objects
    
    var browser: MCNearbyServiceBrowser?
    
    var advertiser: MCNearbyServiceAdvertiser?
    
    fileprivate var dummySession: MCSession?
    
    weak var delegate: SimpleMessageManagerDelegate?
    
    fileprivate let userDefaults = UserDefaults.standard    //To persist MCPeerID
    
    
    //MARK: - Initializers
    
    init(serviceTypeString: String) {
        print("\nSimpleMessageManager init()")
        serviceType = serviceTypeString
        
        // Load MCPeerID if it exists
        if let peerIdData = userDefaults.data(forKey: Keys.PEER_ID_KEY) {
            myPeerID = NSKeyedUnarchiver.unarchiveObject(with: peerIdData) as! MCPeerID
        } else {
            // Create MCPeerID and persist it for next time.
            myPeerID = MCPeerID(displayName: Constants.DEFAULT_PEER_ID)
            let peerData = NSKeyedArchiver.archivedData(withRootObject: myPeerID)
            userDefaults.set(peerData, forKey: Keys.PEER_ID_KEY)
        }
        
        super.init()
        startBrowsing()
        startAdvertising()
    }
    
    convenience override init() {
        self.init(serviceTypeString: Constants.DEFAULT_SERVICE_TYPE)
    }
    
    deinit {
        browser?.stopBrowsingForPeers()
        advertiser?.stopAdvertisingPeer()
        print("SimpleMessageManager deinit: stopped browsing, stopped advertising")
    }
    
    
    
    //MARK: - MCNearbyServiceAdvertiserDelegate
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        
        print("\nSimpleMessageManager: Invited!\n")
        delegate?.dataRecieved(context!, fromPeer: peerID)
    }
    
    
    //MARK: - MCNearbyServiceBrowserDelegate
    
    // Stores MCPeerID in array
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("peerFound")
        peerArray.append(peerID)
        delegate?.peerFound(peerID)
    }
    
    // Informs delegate that a peer was lost
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("peerLost")
        if let index = peerArray.index(of: peerID) {
            peerArray.remove(at: index)
        }
        delegate?.peerLost(peerID)
    }
    
    
    //MARK: - Utility
    // Create browser if nil, set delegate, start browsing
    func startBrowsing() {
        
        if browser == nil {
            browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
        }
        
        browser!.delegate = self
        browser!.startBrowsingForPeers()
        print("Start Browsing")
    }
    
    func startAdvertising() {
        
        if advertiser == nil {
            advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
        }
        
        advertiser!.delegate = self
        advertiser!.startAdvertisingPeer()
        print("Start Advertising")
    }
    
    func sendMessage(_ message: String, toPeer targetPeerID: MCPeerID) {
        // Convert string to data
        let messageData = message.data(using: String.Encoding.utf8)
        
        self.sendData(messageData!, toPeer: targetPeerID)
    }
    
    func sendData(_ data: Data, toPeer targetPeerID: MCPeerID) {
        // Make session
        dummySession = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .none)
        dummySession?.delegate = self
        
        print("Sending data to: \(targetPeerID.displayName)")
        browser?.invitePeer(targetPeerID, to: dummySession!, withContext: data, timeout: 30)
        print("Data sent")
    }
    
    fileprivate func recieveMessage(_ data: Data) -> String? {
        // Convert data to string
        let message = String(data: data, encoding: String.Encoding.utf8)
        return message
    }
}

extension SimpleMessageManager : MCSessionDelegate {
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("session didRecieveData")
    }
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("session DidChangeState")
    }
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("session didRecieveStream")
    }
    func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        print("session didRecieveCertificate")
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("session didStartRecievingResource")
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        print("session didFinishReceivingResource")
    }
}
