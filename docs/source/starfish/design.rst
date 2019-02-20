Starfish Design
===============


Core
----

.. uml::

   class DID {
     static boolean isValidDID(String did)
     static DID parse(String did)
     String getScheme()
     String getMethod()
     String getID()
     String getPath()
     String getFragment()
     String toString()
     boolean equals(Object o)
     boolean equals(DID d)
     int hashCode()
   }

   class Ocean {
     static Ocean   DEFAULT_OCEAN
     static Ocean   connect()
     JSONObject   getDDO(DID did)
     JSONObject   getDDO(String did)
   }

+-------------+-----------+-----------+
| DID_java_   | DID_py_   | DID_js_   |
+-------------+-----------+-----------+
| Ocean_java_ | Ocean_py_ | Ocean_js_ |
+-------------+-----------+-----------+

.. _DID_java: starfish-java/latest/apidocs/sg/dex/starfish/DID.html
.. _Ocean_java: starfish-java/latest/apidocs/sg/dex/starfish/Ocean.html

.. _DID_py: starfish-py/latest/
.. _Ocean_py: starfish-py/latest/

.. _DID_js: starfish-js/latest/
.. _Ocean_js: starfish-js/latest/

Assets
------

.. uml::

   abstract class AAsset {
     String getAssetID()
     JSONObject getMetadata()
     String getMetadataString()
     boolean isDataAsset()
     String toString()
   }

   Asset <|-- AAsset

   abstract class ADataAsset {
     byte[] getBytes()
     long getSize()
     boolean isDataAsset()
     boolean isOperation()
   }

   AAsset <|-- ADataAsset
   DataAsset <|-- ADataAsset

   interface Asset {
     DataAsset asDataAsset()
     String getAssetID()
     byte[] getBytes()
     JSONObject getMetadata()
     String getMetadataString()
     boolean isDataAsset()
     boolean isOperation()
   }

   class AssetBundle {
     Asset getContent(String path)
     List<String> getContentIDs()
     boolean isDataAsset()
     boolean isOperation()
   }

   AAsset <|-- AssetBundle
   Asset <|-- AssetBundle

   interface DataAsset {
     byte[] getBytes()
     InputStream getInputStream()
     boolean isDataAsset()
   }

   Asset <|-- DataAsset

   class FileAsset {
     FileAsset create(File f)
     File getFile()
     InputStream getInputStream()
     long getSize()
   }

   DataAsset <|-- FileAsset
   ADataAsset <|-- FileAsset

   class MemoryAsset {
     static MemoryAsset create(Asset a)
     static MemoryAsset create(byte[] data)
     static MemoryAsset create(Map<Object,Object> meta, byte[] data)
     byte[] getBytes()
     InputStream getInputStream()
     long getSize()
     boolean isDataAsset()
   }

   DataAsset <|-- MemoryAsset
   ADataAsset <|-- MemoryAsset

   class RemoteAsset {
     static Asset create(String meta, String urlString)
     static Asset create(String meta, URL url)
     InputStream getInputStream()
     long getSize()
     URL getURL()
     String getURLString()
     boolean isDataAsset()
   }

   DataAsset <|-- RemoteAsset
   ADataAsset <|-- RemoteAsset

   class ResourceAsset {
     static Asset create(String meta, String resourcePath)
     InputStream getInputStream()
     String getName()
     long getSize()
   }

   DataAsset <|-- ResourceAsset
   ADataAsset <|-- ResourceAsset

+---------------------+-------------------+-------------------+
| AAsset_java_        | AAsset_py_        | AAsset_js_        |
+---------------------+-------------------+-------------------+
| ADataAsset_java_    | ADataAsset_py_    | ADataAsset_js_    |
+---------------------+-------------------+-------------------+
| Asset_java_         | Asset_py_         | Asset_js_         |
+---------------------+-------------------+-------------------+
| AssetBundle_java_   | AssetBundle_py_   | AssetBundle_js_   |
+---------------------+-------------------+-------------------+
| DataAsset_java_     | DataAsset_py_     | DataAsset_js_     |
+---------------------+-------------------+-------------------+
| FileAsset_java_     | FileAsset_py_     | FileAsset_js_     |
+---------------------+-------------------+-------------------+
| MemoryAsset_java_   | MemoryAsset_py_   | MemoryAsset_js_   |
+---------------------+-------------------+-------------------+
| RemoteAsset_java_   | RemoteAsset_py_   | RemoteAsset_js_   |
+---------------------+-------------------+-------------------+
| ResourceAsset_java_ | ResourceAsset_py_ | ResourceAsset_js_ |
+---------------------+-------------------+-------------------+

.. _AAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/AAsset.html
.. _ADataAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/ADataAsset.html
.. _Asset_java: starfish-java/latest/apidocs/sg/dex/starfish/Asset.html
.. _AssetBundle_java: starfish-java/latest/apidocs/sg/dex/starfish/AssetBundle.html
.. _DataAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/DataAsset.html
.. _FileAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/file/FileAsset.html
.. _MemoryAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/memory/MemoryAsset.html
.. _RemoteAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/remote/RemoteAsset.html
.. _ResourceAsset_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/url/ResourceAsset.html

.. _AAsset_py: starfish-py/latest/
.. _ADataAsset_py: starfish-py/latest/
.. _Asset_py: starfish-py/latest/
.. _AssetBundle_py: starfish-py/latest/
.. _DataAsset_py: starfish-py/latest/
.. _FileAsset_py: starfish-py/latest/
.. _MemoryAsset_py: starfish-py/latest/
.. _RemoteAsset_py: starfish-py/latest/
.. _ResourceAsset_py: starfish-py/latest/

.. _AAsset_js: starfish-js/latest/
.. _ADataAsset_js: starfish-js/latest/
.. _Asset_js: starfish-js/latest/
.. _AssetBundle_js: starfish-js/latest/
.. _DataAsset_js: starfish-js/latest/
.. _FileAsset_js: starfish-js/latest/
.. _MemoryAsset_js: starfish-js/latest/
.. _RemoteAsset_js: starfish-js/latest/
.. _ResourceAsset_js: starfish-js/latest/

Agents
------

.. uml::

   abstract class AAgent {
     JSONObject getDDO()
     DID getDID()
     JSONObject refreshDDO()
   }

   Agent <|-- AAgent

   interface Agent {
     Asset getAsset(String id)
     JSONObject getDDO()
     DID getDID()
     void registerAsset(Asset a)
     Asset uploadAsset(Asset a)
   }

   interface InvokableAgent {
     Job invoke(Operation operation, Asset... params)
   }

   class MemoryAgent {
     static MemoryAgent DEFAULT
     static MemoryAgent create()
     static MemoryAgent create(DID did)
     static MemoryAgent create(String did)
     Asset getAsset(String id)
     Job invoke(Operation operation, Asset... params)
     void registerAsset(Asset a)
     Asset uploadAsset(Asset a)
   }

   AAgent <|-- MemoryAgent
   InvokableAgent <|-- MemoryAgent

   class RemoteAgent {
      Asset getAsset(String id)
      String getAssetURL(String id)
      void registerAsset(Asset a)
      Asset uploadAsset(Asset a)
   }

   AAgent <|-- RemoteAgent

+----------------------+--------------------+--------------------+
| AAgent_java_         | AAgent_py_         | AAgent_js_         |
+----------------------+--------------------+--------------------+
| Agent_java_          | Agent_py_          | Agent_js_          |
+----------------------+--------------------+--------------------+
| InvokableAgent_java_ | InvokableAgent_py_ | InvokableAgent_js_ |
+----------------------+--------------------+--------------------+
| MemoryAgent_java_    | MemoryAgent_py_    | MemoryAgent_js_    |
+----------------------+--------------------+--------------------+
| RemoteAgent_java_    | RemoteAgent_py_    | RemoteAgent_js_    |
+----------------------+--------------------+--------------------+

.. _AAgent_java: starfish-java/latest/apidocs/sg/dex/starfish/AAgent.html
.. _Agent_java: starfish-java/latest/apidocs/sg/dex/starfish/Agent.html
.. _InvokableAgent_java: starfish-java/latest/apidocs/sg/dex/starfish/InvokableAgent.html
.. _MemoryAgent_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/memory/MemoryAgent.html
.. _RemoteAgent_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/remote/RemoteAgent.html

.. _AAgent_py: starfish-py/latest/
.. _Agent_py: starfish-py/latest/
.. _InvokableAgent_py: starfish-py/latest/
.. _MemoryAgent_py: starfish-py/latest/
.. _RemoteAgent_py: starfish-py/latest/

.. _AAgent_js: starfish-js/latest/
.. _Agent_js: starfish-js/latest/
.. _InvokableAgent_js: starfish-js/latest/
.. _MemoryAgent_js: starfish-js/latest/
.. _RemoteAgent_js: starfish-js/latest/

Listings
--------

.. uml::

   abstract class AListing {
   }

   Listing <|-- AListing

   interface Listing {
     Object getAgreement()
     Asset getAsset()
     JSONObject getMetadata()
   }

+----------------+--------------+--------------+
| AListing_java_ | AListing_py_ | AListing_js_ |
+----------------+--------------+--------------+
| Listing_java_  | Listing_py_  | Listing_js_  |
+----------------+--------------+--------------+

.. _AListing_java: starfish-java/latest/apidocs/sg/dex/starfish/AListing.html
.. _Listing_java: starfish-java/latest/apidocs/sg/dex/starfish/Listing.html

.. _AListing_py: starfish-py/latest/
.. _Listing_py: starfish-py/latest/

.. _AListing_js: starfish-js/latest/
.. _Listing_js: starfish-js/latest/

Jobs
----

.. uml::

   interface Asset

   abstract class AMemoryOperation {
     Job invoke(Asset... params)
   }

   Operation <|-- AMemoryOperation

   interface Job {
     Asset getResult()
     boolean isComplete()
   }

   class MemoryJob {
     Asset getResult()
     boolean isComplete()
   }

   Job <|-- MemoryJob

   interface Operation {
     boolean isOperation()
   }

   Asset <|-- Operation

+------------------------+----------------------+----------------------+
| AMemoryOperation_java_ | AMemoryOperation_py_ | AMemoryOperation_js_ |
+------------------------+----------------------+----------------------+
| Job_java_              | Job_py_              | Job_js_              |
+------------------------+----------------------+----------------------+
| MemoryJob_java_        | MemoryJob_py_        | MemoryJob_js_        |
+------------------------+----------------------+----------------------+
| Operation_java_        | Operation_py_        | Operation_js_        |
+------------------------+----------------------+----------------------+

.. _AMemoryOperation_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/memory/AMemoryOperation.html
.. _Job_java: starfish-java/latest/apidocs/sg/dex/starfish/Job.html
.. _MemoryJob_java: starfish-java/latest/apidocs/sg/dex/starfish/impl/memory/MemoryJob.html
.. _Operation_java: starfish-java/latest/apidocs/sg/dex/starfish/Operation.html

.. _AMemoryOperation_py: starfish-py/latest/
.. _Job_py: starfish-py/latest/
.. _MemoryJob_py: starfish-py/latest/
.. _Operation_py: starfish-py/latest/

.. _AMemoryOperation_js: starfish-js/latest/
.. _Job_js: starfish-js/latest/
.. _MemoryJob_js: starfish-js/latest/
.. _Operation_js: starfish-js/latest/


Helpers
-------

.. uml::

   class Hash {
     static byte[] keccak256(byte[] data)
     static byte[] keccak256(byte[] data, int offset, int length)
     static byte[] keccak256(String string)
     static String keccak256String(byte[] data)
     static String keccak256String(String string)
   }

   class Hex {
     static byte[] toBytes(String hex)
     static char toChar(int value)
     static String toString(byte[] data)
     static String toString(byte[] data, int offset, int length)
     static int val(char c)
   }

   class Utils {
     static int	DID_LENGTH
     static String createRandomDIDString()
     static String createRandomHexString(int length)
     static boolean equals(Object a, Object b)
     static <T> Class<T> getClass(T o)
     static int	hashCode(Object o)
   }

+---------------------+-------------------+-------------------+
| Hash_java_          | Hash_py_          | Hash_js_          |
+---------------------+-------------------+-------------------+
| Hex_java_           | Hex_py_           | Hex_js_           |
+---------------------+-------------------+-------------------+
| Utils_java_         | Utils_py_         | Utils_js_         |
+---------------------+-------------------+-------------------+
| TODOException_java_ | TODOException_py_ | TODOException_js_ |
+---------------------+-------------------+-------------------+

.. _Hash_java: starfish-java/latest/apidocs/sg/dex/starfish/crypto/Hash.html
.. _Hex_java: starfish-java/latest/apidocs/sg/dex/starfish/util/Hex.html
.. _Utils_java: starfish-java/latest/apidocs/sg/dex/starfish/Utils.html
.. _TODOException_java: starfish-java/latest/apidocs/sg/dex/starfish/TODOException.html

.. _Hash_py: starfish-py/latest/
.. _Hex_py: starfish-py/latest/
.. _Utils_py: starfish-py/latest/
.. _TODOException_py: starfish-py/latest/

.. _Hash_js: starfish-js/latest/
.. _Hex_js: starfish-js/latest/classes/_sg_dex_starfish_hex_.hex.html
.. _Utils_js: starfish-js/latest/
.. _TODOException_js: starfish-js/latest/

Design Guide
------------

.. toctree::
   :maxdepth: 2

   graphics
