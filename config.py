"""
Base configuration settings for the Sakila Flask application.
Handles database connection strings and system timeouts.
"""

# Name: Ibrahim Asad and Example Team Member
# Date: 27-04-2026

import os

class Config:
    # Database connection settings
    MYSQL_HOST = os.environ.get('MYSQL_HOST', 'sakila-db-server')
    MYSQL_USER = os.environ.get('MYSQL_USER', 'root')
    MYSQL_PASSWORD = os.environ.get('MYSQL_PASSWORD', 'admin')
    MYSQL_DB = os.environ.get('MYSQL_DB', 'sakila')

    # System timeout and health check settings
    CONNECTION_TIMEOUT = int(os.environ.get('CONNECTION_TIMEOUT', '30'))
    HEALTH_CHECK_INTERVAL = int(os.environ.get('HEALTH_CHECK_INTERVAL', '10'))

    # SECURITY NOTE: Ensure this key is rotated regularly in production
    SECRET_KEY = os.environ.get('SECRET_KEY', 'your-secret-key-here-change-this-in-production')