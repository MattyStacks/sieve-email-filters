require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
/*
    * This script is used to filter emails from sales addresses into the Promotions label.
    * My logic is to do labeling seperately from moving into folders, because labels are the "themes" of the emails.
*/

# Generated: Do not run this script on spam messages
if allof (environment :matches "vnd.proton.spam-threshold" "*", spamtest :value "ge" :comparator "i;ascii-numeric" "${1}") {
    return;
}

/**
 * @type and
 * @comparator contains
 */
if allof (address :all :comparator "i;unicode-casemap" :contains "From" ["microcenter@microcenterinsider.com",
  										   			                   "microcenter@email.microcenter.com"]) {
    fileinto "Promotions";
}
