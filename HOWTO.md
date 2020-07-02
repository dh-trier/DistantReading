# Publishing the ELTeC Corpora in TextGridRep

This document offers an overview about the workflow to publish the ELTeC corpora in TextGridRep. Very briefly, the Python scripts take as import each language corpus from a folder and create the necessary XML documents that are necessary to describe a text in the TextGridRep model of objects. These objects are then fed to the Kolibri system, which import all files automatically into TextGrid.

<!--todo: <img src="workflow.png" />-->

# The Challenges Associated with Large Collections of Texts:
## Why Do we Need Many Metadata Fields (and perhaps many Files) to Manage our Corpora?

In a short collection of texts, each text can be described only using the information of the title, the author and perhaps the year. However, when the number of texts increase, the different abstract levels become obvious. If a data base contains several translations and editions of the same work, the researcher would probably want to link all these texts. Furthermore, the researcher perhaps wants to arrange the texts in several corpora: works with a specific thematic, works published in a specific decade, etc. All these represent several

# TextGrid and its Objects
The Repository and the Laboratory software of TextGrid have a complex system of different types of <a href="https://wiki.de.dariah.eu/display/TextGrid/TextGrid+Objects">**objects**</a>. This is based in <a href="http://www.rda-rsc.org/content/rda_faq#1">Resource Description & Access (RDA)</a> guidelines, which is the standard for many libraries. This model of objects tries to capture accurately the several levels and relations specified in the previous section. The objects in TextGrid are:

- **Collection**: Project object that relates all other **objects (works, editions or items)** generated within the project. Example: the Cost-Action project. <a href="https://wiki.de.dariah.eu/display/TextGrid/Collections">Further documentation</a>.
- **Aggregation**: Group of **objects (works, editions or items)**. Example: the corpus of novels in English of the Cost-Action. <a href="https://wiki.de.dariah.eu/display/TextGrid/Collections">Further documentation</a>.
- **Work**: Single **creation** from one or more authors. Example: *The picture of Dorian Gray* by Oscar Wilde. <a href="https://wiki.de.dariah.eu/display/TextGrid/Works">Further documentation</a>.
- **Edition**: **Manifestation of a work**, for example the edition of *The picture of Dorian Gray* published by Penguin Books in 1994 in soft cover.  <a href="https://wiki.de.dariah.eu/display/TextGrid/Editions">Further documentation</a>.
- **Item**: One specific digitization expressed in XML-TEI of an **edition** of *The picture of Dorian Gray*. <a href="https://wiki.de.dariah.eu/display/TextGrid/Items">Further documentation</a>.

Each of these five types of objects are described as **data** and **metadata**. For example, there is a .collection document and a .collection.meta files. Further <a href="https://wiki.de.dariah.eu/display/TextGrid/TextGrid+Objects">documentation about the objects types can be found in the Wiki of TextGrid</a>.

# ELTeC Described in TextGrid Objects

For the case of the ELTeC, it would represent following documents:

- The <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates">**ELTeC project** is described as a **collection**</a>. This means that means one file for the data of this project (ELTeC.collection) and another one for its metadata (ELTeC.collection.meta) 
- Each <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC">**language corpus** in the ELTeC is described as an **aggregation**</a>. That means that for each language, there is a file for the data of this aggregation (for example: -FRA.aggregation) and another one for the metadata (-FRA.aggregation.meta ).
- Each **text** in the ELTeC is described in **three different levels**:
    - As a <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL/LLLNNN">**work**</a>, described as data (FRA001.work) and metadata (FRA001.work.metadata).
    - As an <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL">**edition**</a>, described as data (FRA001.edition) and metadata (FRA001.edition.meta).
    - As an <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/templates/CCC/LLL/LLLNNN">**item**</a>, described as data (-FRA001.xml) and metadata (-FRA001.xml.meta).

Imagine that ELTeC contains already ten corpora in ten different languages. That would represent 100 TEI documents per language = 1.000 TEI files. These corpora would require in TextGrid:

- 2 files for the ELTeC project
- 2 files for each language (2 * 10 = 20)
- 3 files of metadata for each text (3 * 100 * 10 = 3.000)
- 3 files of data for each text (3 * 100 * 10 = 3.000)
- A total of 6.022 files

# Workflow

## From the TEI ELTeC Files to the TextGrid Objects

1. The original TEI files are located in the <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/input">"input" folder</a>. Each language constitutes a subfolder there. <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/input">See input folder in the GitHub repository</a>.
2. The **python script 1_extract_metadata.py** needs to be called for each language corpus (<a href="https://github.com/dh-trier/DistantReading/blob/master/2020-June/1_extract_metadata.py">see script in the GitHub repository</a>).
3. The **python script 1_extract_metadata.py outputs a table in a TSV format**, which contains all the metadata of each language corpus. In this files, the rows are texts, and the columns are metadata fields. These files are saved by the script in the <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/metadata">folder "metadata" (see in GitHub)</a>.
4. The **python script 2_build_tgrfiles.py** needs to be called for each language. It takes the metadata table in the "metadata" subfolder and creates the necessary XML files that describe the corpora and the files as TextGrid objects. These files are saved in <a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output">the "output" folder (see in GitHub)</a>. Specifically, it creates following files:
    1. It creates the **collection files** (<a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output">ELTeC.collection and ELTeC.collection.meta, see in GitHub</a>)
    2. It creates the **aggregation files for each language corpus** (<a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output">-ENG.aggregation and -ENG.aggregation.metadata, see in GitHub</a>)
    3. It creates the **work files for each text** (<a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output/ELTeC/ENG/ENG001">ENG001.work and ENG001.work.metadata, see in GitHub</a>)
    4. It creates the **edition files for each text** (<a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output/ELTeC/ENG/">ENG001.edition and ENG001.edition.metadata, see in GitHub</a>)
    5. It creates the **item files for each text** (<a href="https://github.com/dh-trier/DistantReading/tree/master/2020-June/output/ELTeC/ENG/ENG001">ENG001.work and ENG001.work.metadata, see in GitHub</a>)
5. Once these files are created, they map the structure that TextGrid requires for the import:

        ►ELTeC
        |_______DEU.aggregation
        |_______DEU.aggregation.meta
        |_____►DEU
        | |_________DEU001.edition
        | |_________DEU001.edition.meta
        | |_______►DEU001
        | |__________-DEU001.xml
        | |__________-DEU001.xml.meta
        | |__________DEU001.work
        | |__________DEU001.work.meta
        |
        |


## Import through Kolibri into TextGrid
After all these files are created, they can all be automatically imported through <a href="https://dev.textgridlab.org/doc/services/submodules/kolibri/kolibri-addon-textgrid-import/docs/import_and_configuration.html">Kolibri</a>. This has been already tested with the files from the ELTeC. Coworkers of the Research and Development department of the State and University Library of Göttingen are actively supporting this tool. 

# References
Certain sections of these "howto.md" file have been taken from the "Project Seminar: Final Report" by Schöch, Schönau and Chen.
