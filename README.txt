<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="13142" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" useSafeAreas="YES" colorMatched="YES">
    <dependencies>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12042"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
    </objects>
</document>

The Neighbourhelp-App is supposed to help people to get help for daily tasks they are unable to do themselves
Pages:
    Login
    Registration
    Tabview
        List of Entries
            Detailview of Entries
        Entry-Creationpage
Possible additions in the future:
    Chatpage
    Localization of users to restrict shown entries with a certain distance radius
Authentication provided by Firebase
Database provided by  Firebase

To get all the needed dependencies (Guide: https://firebase.google.com/docs/ios/setup)
1.  (Optional if you get a external config file) Add a realtime database and authentication to your firebase project
2.  Add the GoogleService.Info.plist as firebase-configuration-file to your projects root directory
        - either get a external configuration file
        - or create a new own firebase project
3.  Open a console and change to your projects directory
4.  Run pod init
5.  Add the following lines to the top of your pod file:
        add pods for desired Firebase products
        #https://firebase.google.com/docs/ios/setup#available-pods
6.  add the following pods to your pod file:
        - pod 'Firebase'
        - pod 'Firebase/Auth'
        - pod 'Firebase/Database'
7.  Run pod install

Note: only use the created .xcworkspace file from now on
