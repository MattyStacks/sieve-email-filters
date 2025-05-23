# Sieve Email Filters

A collection of Sieve email filtering scripts designed for ProtonMail and other compatible email services. My examples will be for protonmail, so if you are using another provider like fastmail. You will probably need to switch some proton specific actions for their's.


## What is Sieve?

Sieve is a programming language designed specifically for email filtering. It allows users to create rules for processing emails as they arrive at the mail server, before they reach your inbox. Sieve scripts can:

- Sort messages into different folders
- Forward or redirect messages
- Send automatic replies
- Reject or discard messages
- Flag messages with specific attributes
- File messages based on header information or content

## Why Use Sieve?

- **Server-side filtering**: Filters run on the mail server, not your client device
- **Standardized**: RFC 5228 compliant and supported by many mail servers
- **Powerful**: Complex filtering logic with minimal code
- **Portable**: Scripts work across any Sieve-compatible email service
- **Efficient**: Reduces bandwidth usage by filtering unwanted mail before download

## ProtonMail and Sieve

ProtonMail supports Sieve filters through their paid plans. With Sieve in ProtonMail, you can:

- Create custom filtering rules beyond their basic filter interface
- Implement advanced organization workflows
- Set up auto-replies or vacation responses
- Manage multiple email identities with specific handling rules
- Filter messages based on complex criteria

## Getting Started

### ProtonMail Sieve Setup

1. Log into your ProtonMail account (requires paid plan)
2. Go to Settings → Filters → Add Sieve Filter
3. Create a new filter and paste your Sieve script
4. Save and activate the filter

### Basic Sieve Script Structure

```shell
require ["fileinto", "reject", "vacation"];

# Filter messages from specific sender
if address :is "from" "example@domain.com" {
    fileinto "Important";
}

# Filter based on subject
if header :contains "subject" "urgent" {
    fileinto "Urgent";
}

# Reject spam
if header :contains "subject" "[SPAM]" {
    reject "This message appears to be spam. Please do not send me spam.";
}
```

- [Fastmail Sieve Supported Extensions](https://www.fastmail.help/hc/en-us/articles/1500000280481-Using-Sieve-scripts-in-Fastmail#sieveextensions)

- [Protonmail Sieve Supported Actions](https://proton.me/support/sieve-advanced-custom-filters#supported-actions-tests)



## Examples

This repository contains practical examples of Sieve scripts for various email management scenarios:

- Promotions organization
- Alias Management
- Expiring Emails

## Resources

- [Sieve Language Documentation](https://datatracker.ietf.org/doc/html/rfc5228)
- [ProtonMail Sieve Documentation](https://proton.me/support/sieve-advanced-custom-filters)
- [Fastmail Sieve Documentation](https://www.fastmail.help/hc/en-us/articles/360060591373-How-to-use-Sieve)
- [Sieve Filter Examples](https://thsmi.github.io/sieve-reference/en/examples.html)
- [Testing Sieve Scripts](https://www.fastmail.com/cgi-bin/sievetest.pl)

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE).

## Contributing

Contributions of new Sieve scripts, improvements to existing ones, or documentation enhancements are welcome. Please feel free to submit pull requests or open issues to discuss new filter ideas.

## TODO

 - [ ] Need to really work on the spam check filtering. Only have a working stubb right now.