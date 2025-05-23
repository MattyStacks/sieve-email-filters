require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags", "environment"];
/*
    * This is sieve labels all the addresses with the finance label.
*/

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

/**
 * @type and
 * @comparator contains
 */

# Finance-related email addresses filter
if anyof (
    # PayPal
    address :all :comparator "i;unicode-casemap" :contains "From" ["notification@paypal.com", "service@paypal.com", "noreply@paypal.com", "updates@paypal.com"],
    
    # Banks (major US banks)
    address :all :comparator "i;unicode-casemap" :contains "From" ["bankofamerica.com", "chase.com", "wellsfargo.com", "citibank.com", "usbank.com", "capitalone.com", "discover.com"],
    
    # Credit Cards
    address :all :comparator "i;unicode-casemap" :contains "From" ["americanexpress.com", "visa.com", "mastercard.com"],
    
    # Investment/Trading
    address :all :comparator "i;unicode-casemap" :contains "From" ["schwab.com", "fidelity.com", "etrade.com", "robinhood.com", "tdameritrade.com", "vanguard.com", "merrilledge.com"],
    
    # Cryptocurrency
    address :all :comparator "i;unicode-casemap" :contains "From" ["coinbase.com", "binance.com", "kraken.com", "gemini.com", "crypto.com"],
    
    # Digital Wallets & Payment Services
    address :all :comparator "i;unicode-casemap" :contains "From" ["venmo.com", "zelle.com", "applepay@apple.com", "googlepay@google.com", "cashapp.com"],
    
    # Tax Services
    address :all :comparator "i;unicode-casemap" :contains "From" ["turbotax.com", "hrblock.com", "taxact.com", "freetaxusa.com"],
    
    # Financial Software/Services
    address :all :comparator "i;unicode-casemap" :contains "From" ["mint.com", "quickbooks.com", "personalcapital.com", "ynab.com", "experian.com", "creditkarma.com", "equifax.com", "transunion.com"]
) {
    fileinto "finance";
}