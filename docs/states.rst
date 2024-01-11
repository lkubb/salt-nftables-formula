Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``nftables``
^^^^^^^^^^^^
*Meta-state*.

This installs the nftables package,
manages the nftables configuration file
and then starts the associated nftables service.


``nftables.package``
^^^^^^^^^^^^^^^^^^^^
Installs the nftables package only.


``nftables.config``
^^^^^^^^^^^^^^^^^^^
Manages the nftables service configuration.
Has a dependency on `nftables.package`_.


``nftables.service``
^^^^^^^^^^^^^^^^^^^^
Starts the nftables service and enables it at boot time.
Has a dependency on `nftables.config`_.


``nftables.clean``
^^^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``nftables`` meta-state
in reverse order, i.e.
stops the service,
removes the configuration file and then
uninstalls the package.


``nftables.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the nftables package.
Has a dependency on `nftables.config.clean`_.


``nftables.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the nftables service and has a
dependency on `nftables.service.clean`_.


``nftables.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the nftables service and disables it at boot time.


