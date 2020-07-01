# Publishing the ELTeC Corpora in TextGridRep

This document offers an overview about the workflow to publish the ELTeC corpora in TextGridRep. Very briefly, the Python scripts take as import each language corpus from a folder and create the necessary XML documents that are necessary to describe a text in the TextGridRep model of objects. These objects are then fed to the Kolibri system, which import all files automatically into TextGrid.

<!--todo: <img src="workflow.png" />-->

# The Challenges Associated with Large Collections of Texts: Why Do we Need Abstract Concepts to Manage our Corpora?

In a short collection of texts, each text can be described only using the information of the title, the author and perhaps the year. However, when the number of texts increase, the different abstract levels become obvious. If a data base contains several translations and editions of the same work, the researcher would probably want to link all these texts. Furthermore, the researcher perhaps wants to arrange the texts in several corpora: works with a specific thematic, works published in a specific decade, etc. All these represent several

# TextGrid and its Objects
The Repository and the Laboratory software of TextGrid have a complex system of different types of <a href="https://wiki.de.dariah.eu/display/TextGrid/TextGrid+Objects">**objects**</a>. This is based in <a href="http://www.rda-rsc.org/content/rda_faq#1">Resource Description & Access (RDA)</a> guidelines, which is the standard for many libraries. This model of objects tries to capture accurately the several levels and relations specified in the previous section. The objects in TextGrid are:

- **Collection**: Project object that relates all other **objects (works, editions or elements)** generated within the project. Example: the Cost-Action project.
- Aggregation: Group of **objects (works, editions or elements)**. Example: the corpus of novels in English of the Cost-Action.
- Work: Single **creation** from one or more authors. Example: The picture of Dorian Gray by Oscar Wilde.
- Edition: **Manifestation of a work**, for example the edition of The picture of Dorian Gray published by Penguin Books in 1994 in soft cover. 
- Element: One specific digitization expressed in XML-TEI of an **edition** of The picture of Dorian Gray.

Each of these five types of objects are described as **data** and **metadata**. For example, there is a .collection document and a .collection.meta files. Further <a href="<a href="https://wiki.de.dariah.eu/display/TextGrid/TextGrid+Objects">documentation about the objects types can be found in the Wiki of TextGrid</a>.

# ELTeC Described in TextGrid Objects

For the case of the ELTeC, it would represent following documents:

- The <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates">**ELTeC project** is described as a **collection**</a>. This means that means one file for the data of this project (ELTeC.collection) and another one for its metadata (ELTeC.collection.meta) 
- Each <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC">**language corpus** in the ELTeC is described as an **aggregation**</a>. That means that for each language, there is a file for the data of this aggregation (for example: -FRA.aggregation) and another one for the metadata (-FRA.aggregation.meta ).
- Each **text** in the ELTeC is described in **three different levels**:
    - As a <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL/LLLNNN">**work**</a>, described as data (FRA001.work) and metadata (FRA001.work.metadata).
    - As an <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL">**edition**</a>, described as data (FRA004.edition) and metadata (FRA004.edition.meta).
    - As an <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL/LLLNNN">**element**</a>, described as data (-FRA001.xml) and metadata (-FRA001.xml.meta).

If ELTeC would contain ten corpora in ten different languages, it will require:

- 2 files for the ELTeC project
- 2 files for each language (2*10 = 20)
- 6 files for each text (6 * 100 *10 = 6.000)
- A total of 6.022 files.

# Import through Kolibri
After all these files are created, they can all be automtically imported through <a href="https://dev.textgridlab.org/doc/services/submodules/kolibri/kolibri-addon-textgrid-import/docs/import_and_configuration.html">Kolibri</a>. This has been already tested with the files from the ELTeC. Coworkers of the Research and Development department of the State and University Library of Göttingen are actively supporting this tool. 
