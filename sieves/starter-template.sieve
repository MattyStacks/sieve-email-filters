require ["include", "environment", "variables", "relational", "comparator-i;ascii-numeric", "spamtest"];
require ["fileinto", "imap4flags"];
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

 # This is a test rule to move emails from inbox to a test folder.
if allof (address :all :comparator "i;unicode-casemap" :contains "From" "test@test.com") {
    fileinto "test";
}