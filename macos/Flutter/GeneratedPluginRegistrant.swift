//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import firebase_analytics
import firebase_core
import local_auth_darwin
import location
import package_info_plus
import path_provider_foundation
import sentry_flutter
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  FLTFirebaseAnalyticsPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAnalyticsPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  FLALocalAuthPlugin.register(with: registry.registrar(forPlugin: "FLALocalAuthPlugin"))
  LocationPlugin.register(with: registry.registrar(forPlugin: "LocationPlugin"))
  FPPPackageInfoPlusPlugin.register(with: registry.registrar(forPlugin: "FPPPackageInfoPlusPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  SentryFlutterPlugin.register(with: registry.registrar(forPlugin: "SentryFlutterPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
