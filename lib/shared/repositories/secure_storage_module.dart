import 'dart:math';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// A module that provides a singleton instance of FlutterSecureStorage
/// with generated webOptions for encryption wrapping.
@module
abstract class SecureStorageModule {
  @singleton
  FlutterSecureStorage get flutterSecureStorage => FlutterSecureStorage(
        webOptions: WebOptions(
          wrapKey: webWrapKey,
          wrapKeyIv: webWrapKeyIv,
        ),
      );
}

/// Generates a random hexadecimal string based on the specified number
/// of bytes.
///
/// [byteLength]: The number of random bytes to generate.
/// For AES-256, a key should be 32 bytes long (resulting in a 64-character
/// hex string).
/// For an initialization vector (IV), typically 16 bytes are used (resulting
/// in a 32-character hex string).
String _generateRandomHex(int byteLength) {
  // Create a cryptographically secure random number generator.
  final secureRandom = Random.secure();

  // Generate a list of random bytes (0 to 255) with a fixed length.
  final randomBytes = List<int>.generate(
    byteLength,
    (_) => secureRandom.nextInt(256),
    growable: false, // Explicitly set the list to be non-growable.
  );

  // Convert each byte to a 2-digit hexadecimal string and join them together.
  return randomBytes
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
}

// Generate a random key (32 bytes -> 64 hex characters) for AES-256.
final webWrapKey = _generateRandomHex(32);

// Generate a random initialization vector (16 bytes -> 32 hex characters).
final webWrapKeyIv = _generateRandomHex(16);
