//
//  FocusDetectiveApp.swift
//  FocusDetective
//
//  Created by Mike Piontek on 9/3/24.
//

import SwiftUI

@main
struct FocusDetectiveApp: App {

	@State var observer = FocusObserver()

	private let formatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss.SSSS"
		return formatter
	}()

	var body: some Scene {

		WindowGroup {

			List {

				Text("The most recent application is shown at the top. You can close this window or hide the application, and Focus Detective will continue to detect changes in the background.")
					.font(.callout)
					.padding(.bottom, 4)

				ForEach(observer.changes) { change in
					HStack(alignment: .firstTextBaseline) {
						Text(formatter.string(from: change.date))
							.font(.callout)
							.monospacedDigit()
							.frame(width: 90, alignment: .leading)
						Text(verbatim: change.name)
							.font(.headline)
					}
					.padding(.vertical, 4)
				}

			}
			.frame(minWidth: 380)
			.navigationTitle("Focus Detective")
			.toolbar {
				Button("Open Console", systemImage: "list.bullet.rectangle") {
					let workspace = NSWorkspace.shared
					let url = workspace.urlForApplication(withBundleIdentifier: "com.apple.Console")!
					NSWorkspace.shared.openApplication(at: url, configuration: .init())
				}
			}

		}
		.defaultSize(width: 380, height: 380)
		.defaultPosition(.center)

	}

}

@Observable
@MainActor
class FocusObserver {

	var changes: [FocusChange] = []

	@ObservationIgnored
	private var observer: NSObjectProtocol?

	init() {
		let center = NSWorkspace.shared.notificationCenter
		observer = center.addObserver(forName: NSWorkspace.didActivateApplicationNotification,
			object: nil, queue: nil) { notification in
			let date = Date.now
			let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication
			let name = app?.localizedName ?? "Unknown"
			let change = FocusChange(date: date, name: name)
			Task { @MainActor in
				self.changes.insert(change, at: 0)
			}
		}
	}

}

struct FocusChange: Identifiable {

	let id: UUID
	let date: Date
	let name: String

	init(date: Date, name: String) {
		self.id = UUID()
		self.date = date
		self.name = name
	}

}
