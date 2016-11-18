<?php
/**
 * Wordpress config File, Nothing should be hard coded in this file.
 *
 * @package    Wordpress
 */

/**
 * Set up our global environment constant and load its config first
 * Default: development
 */
define( 'WP_ENV', getenv( 'WP_ENV' ) ? getenv( 'WP_ENV' ) : 'development' );

define( 'DB_NAME', getenv( 'DB_NAME' ) );
define( 'DB_USER', getenv( 'DB_USER' ) );
define( 'DB_PASSWORD', getenv( 'DB_PASSWORD' ) );
define( 'DB_HOST', getenv( 'DB_HOST' ) ? getenv( 'DB_HOST' ) : 'localhost' );

define( 'WP_HOME', getenv( 'WP_HOME' ) );
define( 'WP_SITEURL', getenv( 'WP_SITEURL' ) );

switch ( WP_ENV ) {
	case 'production':
		ini_set( 'display_errors', 0 );
		define( 'WP_DEBUG_DISPLAY', false );
		define( 'SCRIPT_DEBUG', false );
		define( 'DISALLOW_FILE_MODS', true );
	break;
	case 'staging':
		ini_set( 'display_errors', 0 );
		define( 'WP_DEBUG_DISPLAY', false );
		define( 'SCRIPT_DEBUG', false );
		define( 'DISALLOW_FILE_MODS', true );
	break;
	default:
		/* Development */
		define( 'SAVEQUERIES', true );
		define( 'WP_DEBUG', true );
		define( 'SCRIPT_DEBUG', true );
	break;
}

/**
 * Custom Content Directory
 */
define( 'CONTENT_DIR', '/app' );
define( 'WP_CONTENT_DIR',  dirname( __DIR__ ) . '/public' . CONTENT_DIR );
define( 'WP_CONTENT_URL', WP_HOME . CONTENT_DIR );

/**
 * DB settings
 */
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
$table_prefix = getenv( 'DB_PREFIX' ) ? getenv( 'DB_PREFIX' ) : 'wp_';

/**
 * WordPress Localized Language
 * Default: English
 *
 * A corresponding MO file for the chosen language must be installed to app/languages
 */
define( 'WPLANG', '' );

/**
 * Authentication Unique Keys and Salts
 */
define( 'AUTH_KEY',         getenv( 'AUTH_KEY' ) );
define( 'SECURE_AUTH_KEY',  getenv( 'SECURE_AUTH_KEY' ) );
define( 'LOGGED_IN_KEY',    getenv( 'LOGGED_IN_KEY' ) );
define( 'NONCE_KEY',        getenv( 'NONCE_KEY' ) );
define( 'AUTH_SALT',        getenv( 'AUTH_SALT' ) );
define( 'SECURE_AUTH_SALT', getenv( 'SECURE_AUTH_SALT' ) );
define( 'LOGGED_IN_SALT',   getenv( 'LOGGED_IN_SALT' ) );
define( 'NONCE_SALT',       getenv( 'NONCE_SALT' ) );

/**
 * Other Settings
 */
define( 'AUTOMATIC_UPDATER_DISABLED', true );
define( 'DISABLE_WP_CRON', true );
define( 'DISALLOW_FILE_EDIT', true );

/**
 * Put custom settings in additional-settings.php
 */
if ( is_file( dirname( __FILE__ ) . '/additional-settings.php' ) ) {
	require_once dirname( __FILE__ ) . '/additional-settings.php';
}

/**
 * Bootstrap WordPress
 */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH',  dirname( __DIR__ ) . '/public/wp/' );
}
