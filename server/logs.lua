function SupermarketDiscordLog(title, description, color)
    PerformHttpRequest("VOTRE WEBHOOK", function(err, text, headers) end, "POST", json.encode({
        embeds = {
            {
                title = title,
                description = description,
                color = color,
                footer = {
                    text = os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }
    }), {["Content-Type"] = "application/json"})
end