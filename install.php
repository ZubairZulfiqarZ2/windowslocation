<?php
/**
 * This function is called on installation and is used to create database schema for the plugin
 */
function extension_install_windowslocation()
{
    $commonObject = new ExtensionCommon;

    $commonObject->sqlQuery("CREATE TABLE IF NOT EXISTS `windowslocation` (
        `ID` INT(11) NOT NULL AUTO_INCREMENT,
        `HARDWARE_ID` INT(11) NOT NULL,
        `PERMISSION` VARCHAR(32) DEFAULT NULL,
        `STATUS` VARCHAR(32) DEFAULT NULL,
        `LATITUDE` VARCHAR(32) DEFAULT NULL,
        `LONGITUDE` VARCHAR(32) DEFAULT NULL,
        `ALTITUDE` VARCHAR(32) DEFAULT NULL,
        `HORIZONTALACCURACY` VARCHAR(32) DEFAULT NULL,
        `VERTICALACCURACY` VARCHAR(32) DEFAULT NULL,
        `SPEED` VARCHAR(32) DEFAULT NULL,
         `ISUNKNOWN` VARCHAR(32) DEFAULT NULL,
        PRIMARY KEY (`ID`, `HARDWARE_ID`)
      ) ENGINE=INNODB;");
}

/**
 * This function is called on removal and is used to destroy database schema for the plugin
 */
function extension_delete_windowslocation()
{
    $commonObject = new ExtensionCommon;
    $commonObject->sqlQuery("DROP TABLE `windowslocation`;");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_windowslocation()
{
    // Placeholder for future upgrades
}