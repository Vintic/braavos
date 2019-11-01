<cfscript>
// =====================================================================
// =     General purpose encrypt/decrypt functions
// =====================================================================
/**
* Encrypt a value using the main application key
*
* [section: Application]
* [category: Authentication]
*
* @value the string to encrypt
*
*/
function encryptString(required string value) {
	return encrypt(
		arguments.value,
		application.encryptionKey,
		"AES/CBC/PKCS5Padding",
		"HEX"
	);
}

/**
* Decrypt a value using the main application key
*
* [section: Application]
* [category: Authentication]
*
* @value the string to decrypt
*
*/
function decryptString(required string value) {
	return decrypt(
		arguments.value,
		application.encryptionKey,
		"AES/CBC/PKCS5Padding",
		"HEX"
	);
}
</cfscript>

