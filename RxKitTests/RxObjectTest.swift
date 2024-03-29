//
//  RxKitTests.swift
//  RxKitTests
//
//  Created by Adam Venturella on 10/10/15.
//  Copyright © 2015 Adam Venturella. All rights reserved.
//

import XCTest
@testable import RxKit

class RxObjectText: XCTestCase {

    func testEventWithData() {
        let obj = RxObject()

        obj.listenTo(obj, on: "foo"){ (sender: RxObject, data: String) in
            XCTAssert(sender == obj)
            XCTAssert(data == "lucy")
        }

        obj.trigger("foo", data: "lucy")
    }

    func testEventWithDataIgnoreSender() {
        let obj = RxObject()

        obj.listenTo(obj, on: "foo"){ (_, data: String) in
            XCTAssert(data == "lucy")
        }

        obj.trigger("foo", data: "lucy")
    }

    func testEventWithoutData() {
        let obj = RxObject()

        obj.listenTo(obj, on: "foo"){ (sender: RxObject) in
            XCTAssert(sender == obj)
        }

        obj.trigger("foo")
    }

    func testEventWithoutDataIgnoreSender() {
        let obj = RxObject()
        var value = 0

        obj.listenTo(obj, on: "foo"){
            value++
        }

        obj.trigger("foo")
        XCTAssert(value == 1)
    }

    func testMultipleEvents() {
        let obj = RxObject()
        var value = 0

        obj.listenTo(obj, on: "foo"){
            value++
        }

        obj.listenTo(obj, on: "bar"){
            value++
        }

        obj.listenTo(obj, on: "baz"){
            value++
        }

        obj.trigger("foo")
        obj.trigger("bar")
        obj.trigger("baz")

        XCTAssert(value == 3)
    }

    func testListenToOnceNoSenderNoData(){
        let obj = RxObject()
        var value = 0

        obj.listenToOnce(obj, on: "foo"){
            value++
        }

        obj.trigger("foo")
        obj.trigger("foo")

        XCTAssert(value == 1)
    }

    func testListenToOnceSender(){
        let obj = RxObject()
        var value = 0

        obj.listenToOnce(obj, on: "foo"){ (sender: RxObject) in
            value++
            XCTAssert(obj == sender)
        }

        obj.trigger("foo")
        obj.trigger("foo")

        XCTAssert(value == 1)
    }

    func testListenToOnceSenderAndData(){
        let obj = RxObject()
        var value = 0

        obj.listenToOnce(obj, on: "foo"){ (sender: RxObject, data: String) in
            value++
            XCTAssert(obj == sender)
            XCTAssert(data == "Lucy")
        }

        obj.trigger("foo", data: "Lucy")
        obj.trigger("foo", data: "Lucy")

        XCTAssert(value == 1)
    }
}
