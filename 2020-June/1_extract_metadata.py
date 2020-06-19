#!/usr/bin/env python3

"""
Script (a) for building a metadata table from ELTeC XML-TEI to prepare 
data required for import into the TextGrid Repository.

The XML-TEI files need to be valid against the ELTeC level1 schema.

Usage: The only parameter you should need to adjust is the path
encoded in the variable "inputdir" and "collection", to point it to the 
appropriate language collection folder.

Output: The script writes a file called "[collection].tsv" with the 
metadata about the texts included in the collection to the folder "metadata".   

Please send feedback to Christof at "schoech@uni-trier.de". 
"""




# === Import statements ===

import os
import re
import glob
from os.path import join
from os.path import basename
import pandas as pd
from lxml import etree
from collections import Counter


# === Files and folders ===

inputdir = join("input", "")
collection = "ELTeC-slv"
level = "level1"


# === Parameters === 

xpaths = {"xmlid" : "//tei:TEI/@xml:id", 
          "title" : "//tei:titleStmt/tei:title/text()",
          "gender" : "//tei:textDesc/eltec:authorGender/@key",
          "size" : "//tei:textDesc/eltec:size/@key",
          "reprints" : "//tei:textDesc/eltec:reprintCount/@key",
          "timeslot" : "//tei:textDesc/eltec:timeSlot/@key",
          "firstedition" : "//tei:bibl[@type='firstEdition']/tei:date/text()",
          "digitalSource" : "//tei:bibl[@type='digitalSource']/tei:publisher/text()",
          "language" : "//tei:langUsage/tei:language/@ident",
          "authorid" : "//tei:titleStmt/tei:author/@ref",
          "printedition" : "//tei:bibl[@type='printSource']/tei:date/text()"}

ordering = ["filename", "xmlid", "author", "title", "firstedition", "language", "gender", "size", "reprints", "timeslot", "authorid", "printedition"]

sorting = ["firstedition", True] # column, ascending?


# === Functions ===


def open_file(teiFile): 
    """
    Open and parse the XML file. 
    Returns an XML tree.
    """
    with open(teiFile, "r", encoding="utf8") as infile:
        xml = etree.parse(infile)
        return xml



def get_metadatum(xml, xpath): 
    """
    For each metadata key and XPath defined above, retrieve the 
    metadata item from the XML tree.
    Note that the individual identifers for au-ids and title-ids 
    are not split into individual columns.
    """
    try: 
        namespaces = {'tei':'http://www.tei-c.org/ns/1.0',
                      'eltec':'http://distantreading.net/eltec/ns'}       
        metadatum = xml.xpath(xpath, namespaces=namespaces)[0]
    except: 
        metadatum = "NA"
    # remove extra elements of the ELTeC title.
    metadatum = re.sub(" : ELTeC edition", "", metadatum)
    metadatum = re.sub(" : édition ELTeC", "", metadatum)
    metadatum = re.sub(" : edition ELTeC", "", metadatum)
    metadatum = re.sub(" : ELTeC edition", "", metadatum)
    metadatum = re.sub(" : ELTeC Edition", "", metadatum)
    # make sure language codes have three characters
    metadatum = re.sub("fr$", "fra", metadatum)
    metadatum = re.sub("en$", "eng", metadatum)
    metadatum = re.sub("de$", "deu", metadatum)
    return metadatum


def get_authordata(xml): 
    """
    Retrieve the author field and split it into constituent parts.
    Expected pattern: "name (alternatename) (birth-death)"
    where birth and death are both four-digit years. 
    The alternate name is ignored. 
    Note that the first and last names are not split into separate
    entries, as this is not always a trivial decision to make.
    """
    try: 
        namespaces = {'tei':'http://www.tei-c.org/ns/1.0'}       
        authordata = xml.xpath("//tei:titleStmt/tei:author/text()",
                               namespaces=namespaces)[0]
        author = re.search("(.*?) \(", authordata).group(1)
        birth = re.search("\((\d\d\d\d)", authordata).group(1)
        death = re.search("(\d\d\d\d)\)", authordata).group(1)
    except: 
        author = "NA"
        birth = "NA"
        death = "NA"        
    return author,birth,death



def save_metadata(metadata, metadatafile, ordering, sorting): 
    """
    Save all metadata to a CSV file. 
    The ordering of the columns follows the list defined above.
    """
    metadata = pd.DataFrame(metadata)
    metadata = metadata[ordering]
    metadata = metadata.sort_values(by=sorting[0], ascending=sorting[1])
    print(metadatafile)
    with open(join(metadatafile), "w", encoding="utf8") as outfile: 
        metadata.to_csv(outfile, sep="\t", index=None)


# === Coordinating function ===

def main(inputdir, collection, level, xpaths, ordering, sorting):
    """
    From a collection of ELTeC XML-TEI files,
    create a CSV file with metadata about each file.
    """
    teiFolder = join(inputdir, collection, level, "*.xml")
    metadatafile = join("metadata", collection+".tsv")
    allmetadata = []
    counter = 0
    for teiFile in glob.glob(teiFolder): 
        filename,ext = basename(teiFile).split(".")
        print(filename)
        try: 
            if "schemas" not in filename:
                counter +=1
                keys = []
                metadata = []
                keys.append("filename")
                metadata.append(filename)
                xml = open_file(teiFile)
                author,birth,death = get_authordata(xml)
                keys.extend(["author", "birth", "death"])
                metadata.extend([author, birth, death])
                for key,xpath in xpaths.items(): 
                    metadatum = get_metadatum(xml, xpath)
                    keys.append(key)
                    metadata.append(metadatum)
                allmetadata.append(dict(zip(keys, metadata)))
        except: 
            print("ERROR!!!", filename)
    print("FILES:", counter)
    save_metadata(allmetadata, metadatafile, ordering, sorting)
    
main(inputdir, collection, level, xpaths, ordering, sorting)
