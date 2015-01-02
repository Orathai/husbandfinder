Husband finder via Google Maps Engine API
=========================================

**Purpose :** To find directions between origin and destination (husband's location) via Google map.

Caveat
------

This is *proof of concept*, and not a finished product.

References
----------

* `https://developers.google.com/maps-engine/documentation/start <https://developers.google.com/maps-engine/documentation/start>`_
* `Spark Java Framework <http://www.sparkjava.com/>`_
* `Docker <https://www.docker.com/>`_


Running as docker container
---------------------------

**1.** You can run this project without installing java if you use docker::

     docker build -t husbandfinder .
     docker run --rm -p 5678:5678 --name husbandfinder husbandfinder

As you bind the docker application to your local port, you can still use the
instructions from the documentation, if your docker installation is local.

With a remote docker installation, you have to
access your application with the **actual IP address**, and not localhost, as
localhost for the application is where the docker container runs.

**2.** Run application via browser "YOUR_DOCKER_IP_ADDRESS:5678"

**3.** Get direction via browser "YOUR_DOCKER_IP_ADDRESS:5678/stored.html"


Author
------

Orathai Khanasa, orathai.khanasa@gmail.com

