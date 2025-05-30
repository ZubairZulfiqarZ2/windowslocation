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
        `PERMISSION` VARCHAR(255) DEFAULT NULL,
        `STATUS` VARCHAR(255) DEFAULT NULL,
        `LATITUDE` DOUBLE DEFAULT NULL,
        `LONGITUDE` DOUBLE DEFAULT NULL,
        `ALTITUDE` DOUBLE DEFAULT NULL,
        `HORIZONTALACCURACY` DOUBLE DEFAULT NULL,
        `VERTICALACCURACY` DOUBLE DEFAULT NULL,
        `SPEED` DOUBLE DEFAULT NULL,
         `ISUNKNOWN` BOOLEAN DEFAULT NULL,
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