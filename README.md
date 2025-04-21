IP Checker for SA-MP (MoonLoader)

This script allows you to check the status of any IP address in-game using IPHub API. It detects if the IP is clean, a proxy, or a VPN.

How to use:
Type /checkip <ip> in the SA-MP chat.
Example: /checkip 1.1.1.1

Requirements:
- MoonLoader installed in your GTA San Andreas directory

API Key Setup:
1. Go to https://iphub.info and register a free account.
2. Copy your API key from your dashboard.
3. Open the script file and replace the line:
   local api_key = "YOUR_API_KEY"
   with your real key inside quotes.

Notes:
- The free IPHub plan allows 1,000 API checks per day.
- The script does basic IP format validation before making requests to ensure your daily credits don't go to waste.

Created by: MoonCake_Par, with love.
