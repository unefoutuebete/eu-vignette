import Foundation

enum CountryCatalog {
    static let all: [VignetteCountry] = [
        VignetteCountry(
            id: "AT",
            name: "Austria",
            flag: "🇦🇹",
            summary: "A digital or physical vignette is required on all Austrian motorways and expressways for vehicles up to 3.5 tonnes.",
            officialShopURL: URL(string: "https://shop.asfinag.at/en/")!,
            validityCheckURL: URL(string: "https://shop.asfinag.at/en/")!,
            options: [
                VignetteOption(id: "AT-1D", label: "1 day", price: "€8.60", notes: "Valid immediately when purchased online."),
                VignetteOption(id: "AT-10D", label: "10 days", price: "€11.50", notes: "Valid immediately when purchased online."),
                VignetteOption(id: "AT-2M", label: "2 months", price: "€28.90", notes: "Online purchases start on day 18 due to withdrawal period."),
                VignetteOption(id: "AT-1Y", label: "1 year", price: "€96.40", notes: "Online purchases start on day 18 due to withdrawal period.")
            ],
            tips: [
                "Buy only from the official ASFINAG shop.",
                "Register your license plate correctly for digital vignettes.",
                "Section tolls (for example Brenner or Tauern tunnels) are billed separately."
            ]
        ),
        VignetteCountry(
            id: "CH",
            name: "Switzerland",
            flag: "🇨🇭",
            summary: "Swiss motorways require an annual vignette linked to your license plate. Digital and sticker formats are available.",
            officialShopURL: URL(string: "https://via.admin.ch/shop/")!,
            validityCheckURL: URL(string: "https://via.admin.ch/")!,
            options: [
                VignetteOption(id: "CH-1Y", label: "1 year", price: "CHF 40", notes: "Valid for one calendar year (Dec 1 to Jan 31).")
            ],
            tips: [
                "Purchase from via.admin.ch or authorized sales points.",
                "The digital vignette is tied to your license plate.",
                "Check validity online before entering Swiss motorways."
            ]
        ),
        VignetteCountry(
            id: "SI",
            name: "Slovenia",
            flag: "🇸🇮",
            summary: "Motorways in Slovenia require an e-vignette registered to your vehicle license plate.",
            officialShopURL: URL(string: "https://evinjeta.dars.si/en")!,
            validityCheckURL: URL(string: "https://evinjeta.dars.si/en")!,
            options: [
                VignetteOption(id: "SI-7D", label: "7 days", price: "€16.00", notes: nil),
                VignetteOption(id: "SI-1M", label: "1 month", price: "€32.00", notes: nil),
                VignetteOption(id: "SI-1Y", label: "1 year", price: "€117.50", notes: nil)
            ],
            tips: [
                "Digital vignettes activate based on the selected start date.",
                "Double-check plate format before confirming payment."
            ]
        ),
        VignetteCountry(
            id: "HU",
            name: "Hungary",
            flag: "🇭🇺",
            summary: "Hungarian motorways use the e-matrica system. Purchase and register your plate before driving on toll roads.",
            officialShopURL: URL(string: "https://ematrica.nemzetiutdij.hu/en/")!,
            validityCheckURL: URL(string: "https://ematrica.nemzetiutdij.hu/en/")!,
            options: [
                VignetteOption(id: "HU-10D", label: "10 days", price: "HUF 6,400", notes: nil),
                VignetteOption(id: "HU-1M", label: "1 month", price: "HUF 10,360", notes: nil),
                VignetteOption(id: "HU-1Y", label: "1 year", price: "HUF 57,600", notes: nil)
            ],
            tips: [
                "County vignettes and motorway vignettes are different products.",
                "Keep your purchase confirmation until after your trip."
            ]
        ),
        VignetteCountry(
            id: "CZ",
            name: "Czech Republic",
            flag: "🇨🇿",
            summary: "Motorway vignettes (elektronická dálniční známka) are mandatory and linked to your license plate.",
            officialShopURL: URL(string: "https://edalnice.cz/en/index.html")!,
            validityCheckURL: URL(string: "https://edalnice.cz/en/index.html")!,
            options: [
                VignetteOption(id: "CZ-1D", label: "1 day", price: "CZK 200", notes: nil),
                VignetteOption(id: "CZ-10D", label: "10 days", price: "CZK 270", notes: nil),
                VignetteOption(id: "CZ-1M", label: "1 month", price: "CZK 430", notes: nil),
                VignetteOption(id: "CZ-1Y", label: "1 year", price: "CZK 2,440", notes: nil)
            ],
            tips: [
                "Set the vignette start date before entering motorways.",
                "Prices and durations can change each calendar year."
            ]
        ),
        VignetteCountry(
            id: "SK",
            name: "Slovakia",
            flag: "🇸🇰",
            summary: "Slovak motorways require an electronic vignette registered to your license plate.",
            officialShopURL: URL(string: "https://eznamka.sk/en/")!,
            validityCheckURL: URL(string: "https://eznamka.sk/en/")!,
            options: [
                VignetteOption(id: "SK-1D", label: "1 day", price: "€8.10", notes: nil),
                VignetteOption(id: "SK-10D", label: "10 days", price: "€10.80", notes: nil),
                VignetteOption(id: "SK-1M", label: "1 month", price: "€17.10", notes: nil),
                VignetteOption(id: "SK-1Y", label: "1 year", price: "€90.00", notes: nil)
            ],
            tips: [
                "Verify plate country code and format during checkout.",
                "Annual vignettes are often the best value for frequent travel."
            ]
        ),
        VignetteCountry(
            id: "RO",
            name: "Romania",
            flag: "🇷🇴",
            summary: "Romanian motorways use the Rovinieta electronic toll system tied to your vehicle registration.",
            officialShopURL: URL(string: "https://www.roviniete.ro/en/")!,
            validityCheckURL: URL(string: "https://www.roviniete.ro/en/")!,
            options: [
                VignetteOption(id: "RO-7D", label: "7 days", price: "RON varies", notes: "Check current tariffs on the official portal."),
                VignetteOption(id: "RO-30D", label: "30 days", price: "RON varies", notes: nil),
                VignetteOption(id: "RO-1Y", label: "1 year", price: "RON varies", notes: nil)
            ],
            tips: [
                "Tariffs depend on vehicle category.",
                "Keep proof of purchase accessible during roadside checks."
            ]
        ),
        VignetteCountry(
            id: "BG",
            name: "Bulgaria",
            flag: "🇧🇬",
            summary: "Bulgarian motorways require an electronic vignette (e-vignette) linked to your license plate.",
            officialShopURL: URL(string: "https://www.bgtoll.bg/en")!,
            validityCheckURL: URL(string: "https://www.bgtoll.bg/en")!,
            options: [
                VignetteOption(id: "BG-7D", label: "7 days", price: "BGN varies", notes: "Check current tariffs on the official portal."),
                VignetteOption(id: "BG-1M", label: "1 month", price: "BGN varies", notes: nil),
                VignetteOption(id: "BG-1Y", label: "1 year", price: "BGN varies", notes: nil)
            ],
            tips: [
                "Activate the vignette before entering tolled motorway sections.",
                "Weekend and holiday traffic checks are common near borders."
            ]
        ),
        VignetteCountry(
            id: "MD",
            name: "Moldova",
            flag: "🇲🇩",
            summary: "Moldova uses an electronic road vignette for designated national road networks.",
            officialShopURL: URL(string: "https://vinieta.gov.md/en/")!,
            validityCheckURL: URL(string: "https://vinieta.gov.md/en/")!,
            options: [
                VignetteOption(id: "MD-7D", label: "7 days", price: "MDL varies", notes: "Check current tariffs on the official portal."),
                VignetteOption(id: "MD-15D", label: "15 days", price: "MDL varies", notes: nil),
                VignetteOption(id: "MD-30D", label: "30 days", price: "MDL varies", notes: nil)
            ],
            tips: [
                "Confirm route coverage before purchase.",
                "Border crossings may require proof of valid vignette registration."
            ]
        )
    ]

    static func country(id: String) -> VignetteCountry? {
        all.first { $0.id == id }
    }
}
