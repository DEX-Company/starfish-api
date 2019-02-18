Starfish Design
===============

Actors (Identity?)
------------------

.. uml::

   abstract class Actor {
     DID actorId
   }

   class Publisher
   class Consumer
   class AgentOperator

   Actor <|-- Publisher
   Actor <|-- Consumer
   Actor <|-- AgentOperator

   class Group {
     Actor[] actors
   }

Assets
------

.. uml::

   class Asset {
     DID assetID
     Metadata metadata
     getDID()
     getMetadata()
     setAssetMetadata(metadata)
     getSize()
     getBytes()
     getProvenance()
   }

   class AssetData
   class MemoryAsset
   class AssetBundle {
     Asset[] assets
   }

   Asset <|-- AssetData
   Asset <|-- AssetBundle
   AssetData <|-- MemoryAsset

Agents
------

.. uml::

   class Agent {
     DID agentId
     DDO agentDDO
     getDID()
     getDDO()
     register(metadata, account)
     registerAsset()
     getAsset()
   }

   class StorageAgent
   class MemoryAgent
   class MetadataAgent
   class ListingAgent
   class AgreementAgent
   class TrustAgent
   class InvokeAgent
   class IndexAgent

   Agent <|-- StorageAgent
   StorageAgent <|-- MemoryAgent
   Agent <|-- MetadataAgent
   Agent <|-- ListingAgent
   Agent <|-- AgreementAgent
   Agent <|-- TrustAgent
   Agent <|-- InvokeAgent
   Agent <|-- IndexAgent

Listings
--------

.. uml::

   class Metadata

   class AgreementTemplate

   class Agreement

   class Listing {
     DID listingId
     Template template
     Asset asset
     getDID()
     getTemplate()
     getAsset()
   }


PlantUML example
----------------

.. uml::

   abstract class AbstractList
   abstract AbstractCollection
   interface List
   interface Collection

   List <|-- AbstractList
   Collection <|-- AbstractCollection

   Collection <|- List
   AbstractCollection <|- AbstractList
   AbstractList <|-- ArrayList

   class ArrayList {
     Object[] elementData
     size()
   }

   enum TimeUnit {
     DAYS
     HOURS
     MINUTES
   }

   annotation SuppressWarnings


Graphviz example
----------------

.. graphviz::

   digraph structs {
     graph [fontsize=8 splines=true overlap=false rankdir = "LR"];
     node [fontname = "Courier New" shape=record];
     struct1 [label="<f0> left|<f1> middle|<f2> right"];
     struct2 [label="<f0> one|<f1> two"];
     struct3 [label="hello\nworld |{ b |{c|<here> d|e}| f}| g | h"];
     struct4 [label="<f0> three|<f1> four"];
     struct1:f0 -> struct4:f0;
     struct1:f1 -> struct2:f0;
     struct1:f2 -> struct3:here;
   }

Ditaa example
-------------

.. uml::

   @startditaa
   +--------+   +-------+    +-------+
   |        +---+ ditaa +--> |       |
   |  Text  |   +-------+    |diagram|
   |Document|   |!magic!|    |       |
   |     {d}|   |       |    |       |
   +---+----+   +-------+    +-------+
           :                         ^
           |       Lots of work      |
           +-------------------------+
   @endditaa
