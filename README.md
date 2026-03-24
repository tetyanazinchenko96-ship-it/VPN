# LumaVPN (SwiftUI Premium VPN Starter)

LumaVPN is a compile-friendly SwiftUI starter app for a premium-looking iOS VPN product concept focused on legitimate privacy and secure remote access workflows.

> This repository includes a **safe simulated VPN flow** only. It does **not** provide real VPN tunneling until Apple Network Extension entitlements and a packet tunnel provider are implemented.

## App Overview

- Premium gradient-based UI with reusable components and design system.
- MVVM architecture with modular services and model-driven views.
- Onboarding, home dashboard, locations list, paywall, settings, and profile placeholder flows.
- Mock VPN status transitions with timer, mock IP, and network metrics.
- Ready abstraction points for future StoreKit 2 and NetworkExtension integration.

## Architecture

```
App/
Core/
Models/
Services/
ViewModels/
Views/
Components/
Theme/
Utilities/
Resources/
```

### Service Protocols
- `VPNManaging`
- `SubscriptionManaging`
- `SettingsManaging`

### Implementations
- `MockVPNManager` – safe simulated connect/disconnect behavior.
- `MockSubscriptionManager` – mock plans/purchase/restore behavior.
- `DefaultSettingsManager` – UserDefaults persistence.
- `SystemVPNManager` – NetworkExtension-ready stub.

## Mock VPN Flow

1. User taps Connect.
2. State transitions: `disconnected -> connecting`.
3. After ~2.2 seconds, state becomes `connected`.
4. Timer increments elapsed session time and fluctuates mock speeds.
5. Disconnect transitions through `disconnecting` then back to `disconnected`.

No low-level or unsafe network behavior is simulated.

## StoreKit 2 Integration Points

`MockSubscriptionManager` contains replacement points for:
- Fetching products (`Product.products(for:)`)
- Purchasing (`purchase()` transaction flow)
- Restoring purchases (`AppStore.sync()` and entitlement checks)
- Active subscription state mapping

## NetworkExtension Integration Points

`SystemVPNManager` outlines required wiring for:
- `NETunnelProviderManager` lifecycle
- Packet Tunnel Provider extension target
- Provider protocol configuration and secure credential passing
- Connection start/stop using `NEVPNConnection`

## Required Apple Capabilities / Entitlements

To ship real VPN functionality:
1. Request and obtain Apple Network Extension entitlement approval.
2. Enable Network Extensions capability in app target.
3. Add Packet Tunnel Provider extension target.
4. Configure App Groups / keychain sharing as needed for provider communication.
5. Implement and sign production provider with proper provisioning profiles.

Without these, this app intentionally remains a UI + mock-service prototype.

## UserDefaults Persistence

The app persists:
- Onboarding completion
- Selected server
- Theme mode
- Auto-connect
- Connect on Wi-Fi
- Connect on Cellular

## Setup in Xcode

1. Open/create an iOS App project in Xcode named **LumaVPN**.
2. Copy these folders into the project and ensure all files are added to the app target.
3. Set iOS deployment target to iOS 17+ (or adjust APIs if lower).
4. Build and run on iPhone simulator.
5. For real VPN support, add entitlements + packet tunnel extension later.

