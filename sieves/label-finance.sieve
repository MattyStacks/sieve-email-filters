require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags", "environment"];
/*
    * This is the basic starter template for ProtonMail Sieve scripts.
*/

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

/**
 * @type and
 * @comparator contains
 */

# This rule moves emails from "Archive" to "paypal" folder if they're from PayPal
if allof (
    address :all :comparator "i;unicode-casemap" :contains "From" "notification@paypal.com"
) {
    fileinto "finance";
}