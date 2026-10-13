# Notes for app reviewers (draft)

Paste into Play Console → App access and App Store Connect → App Review
Information once the demo account exists.

> Agentfolio connects to a user's existing Angel One (Indian stockbroker)
> account to show their portfolio, explain it with AI, and, on Premium, let an
> AI agent propose trades that the user must approve with Face ID or their
> passcode. It is not a broker; orders are placed through the user's own
> broker account.
>
> Demo login: WhatsApp number `<demo number>`, app password `<demo password>`.
> The demo account is backed by a simulated broker: holdings are sample data
> and approved orders are not sent to any exchange.
>
> To see trading: Trade tab → "Chat with the trading agent" → "Suggest trades",
> then approve or reject the proposal under Trade proposals.
>
> Account deletion: Account → Delete account (requires the app password).

**Still needed before submitting:** the demo user and simulated broker on the
backend (plan §11/§12.3). The real login needs a live Angel One account,
which reviewers do not have.
