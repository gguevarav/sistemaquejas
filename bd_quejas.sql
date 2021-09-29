DROP DATABASE IF EXISTS bd_quejas;

CREATE DATABASE bd_quejas;

USE bd_quejas;

CREATE TABLE Region(
    idRegion                        TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreRegion                    VARCHAR(20)         NOT NULL,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			NULL
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Departamento(
    idDepartamento                  TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreDepartamento              VARCHAR(20)         NOT NULL,
    idRegion                        TINYINT             NOT NULL,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			NULL,
    INDEX (idRegion),
    FOREIGN KEY (idRegion)
            REFERENCES Region(idRegion)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Municipio(
    idMunicipio			            TINYINT 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreMunicipio                 VARCHAR(25)         NOT NULL,
    idDepartamento                  TINYINT             NOT NULL,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			NULL,
    INDEX (idDepartamento),
    FOREIGN KEY (idDepartamento)
            REFERENCES Departamento(idDepartamento)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Proveedor(
    idProveedor                     INTEGER 			NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NombreProveedor                 VARCHAR(20)         NOT NULL,
    NumeroNIT                       VARCHAR(10)         NOT NULL,
    Direccion                       VARCHAR(50)         NOT NULL,
	MunicipioSede					TINYINT 			NOT null,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			null,
	INDEX (MunicipioSede),
    FOREIGN KEY (MunicipioSede)
            REFERENCES Municipio(idMunicipio)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Sucursal(
    idSucursal                      INTEGER             NOT NULL,
    NombreSucursal                  VARCHAR(40)         NOT NULL,
    idProveedor                     INTEGER             NOT NULL,
    idRegion                        TINYINT             NOT NULL,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			NULL,
    INDEX (idProveedor),
    FOREIGN KEY (idProveedor)
            REFERENCES Proveedor(idProveedor)
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
    INDEX (idRegion),
    FOREIGN KEY (idRegion)
            REFERENCES Region(idRegion)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE Queja(
    idQueja                         BIGINT              NOT NULL				PRIMARY KEY             AUTO_INCREMENT,
    NumeroFactura                   VARCHAR(25)         NOT NULL,
    Fecha                           DATE                NOT NULL,
    Queja                           TEXT                NOT NULL,
    Sugerencia                      TEXT                NOT NULL,
    idProveedor                     INTEGER		        NOT NULL,
    created_at				        TIMESTAMP			NULL,
	updated_at				        TIMESTAMP			NULL,
    INDEX (idProveedor),
    FOREIGN KEY (idProveedor)
            REFERENCES Proveedor(idProveedor)
            ON DELETE CASCADE
            ON UPDATE NO ACTION
)ENGINE = InnoDB CHARSET=utf8 COLLATE utf8_spanish_ci;

CREATE TABLE `failed_jobs` (
                               `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                               `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
                               `connection` text COLLATE utf8_unicode_ci NOT NULL,
                               `queue` text COLLATE utf8_unicode_ci NOT NULL,
                               `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
                               `exception` longtext COLLATE utf8_unicode_ci NOT NULL,
                               `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `migrations` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
                              `batch` int(11) NOT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `oauth_access_tokens` (
                                       `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                                       `user_id` bigint(20) unsigned DEFAULT NULL,
                                       `client_id` bigint(20) unsigned NOT NULL,
                                       `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                                       `scopes` text COLLATE utf8_unicode_ci,
                                       `revoked` tinyint(1) NOT NULL,
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL,
                                       `expires_at` datetime DEFAULT NULL,
                                       PRIMARY KEY (`id`),
                                       KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `oauth_auth_codes` (
                                    `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                                    `user_id` bigint(20) unsigned NOT NULL,
                                    `client_id` bigint(20) unsigned NOT NULL,
                                    `scopes` text COLLATE utf8_unicode_ci,
                                    `revoked` tinyint(1) NOT NULL,
                                    `expires_at` datetime DEFAULT NULL,
                                    PRIMARY KEY (`id`),
                                    KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `oauth_clients` (
                                 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                 `user_id` bigint(20) unsigned DEFAULT NULL,
                                 `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
                                 `secret` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
                                 `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
                                 `redirect` text COLLATE utf8_unicode_ci NOT NULL,
                                 `personal_access_client` tinyint(1) NOT NULL,
                                 `password_client` tinyint(1) NOT NULL,
                                 `revoked` tinyint(1) NOT NULL,
                                 `created_at` timestamp NULL DEFAULT NULL,
                                 `updated_at` timestamp NULL DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `oauth_personal_access_clients` (
                                                 `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
                                                 `client_id` bigint(20) unsigned NOT NULL,
                                                 `created_at` timestamp NULL DEFAULT NULL,
                                                 `updated_at` timestamp NULL DEFAULT NULL,
                                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `oauth_refresh_tokens` (
                                        `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                                        `access_token_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
                                        `revoked` tinyint(1) NOT NULL,
                                        `expires_at` datetime DEFAULT NULL,
                                        PRIMARY KEY (`id`),
                                        KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `password_resets` (
                                   `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
                                   `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO Region (idRegion, NombreRegion, created_at, updated_at)
			VALUES (NULL, 'Norte', NULL, NULL),
			       (NULL, 'Sur', NULL, NULL),
			       (NULL, 'Nor Oriente', NULL, NULL),
                   (NULL, 'Occidente', NULL, NULL);

INSERT INTO Departamento (idDepartamento, NombreDepartamento, idRegion, created_at, updated_at)
			VALUES (NULL, 'Izabal', 3, NULL, null);

INSERT INTO Municipio (idMunicipio, NombreMunicipio, idDepartamento, created_at, updated_at)
			VALUES (NULL, 'Puerto Barrios', 1, NULL, NULL),
			       (NULL, 'Morales', 1, NULL, NULL),
			       (NULL, 'Livingston', 1, NULL, NULL),
                   (NULL, 'El Estor', 1, NULL, NULL),
                   (NULL, 'Los Amates', 1, NULL, NULL);

                  
