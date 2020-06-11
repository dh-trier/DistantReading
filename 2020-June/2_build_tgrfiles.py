#!/usr/bin/env python3

"""
Script for creating the various files required for import of data into 
the TextGrid Repository. 

The script requires the metadata file produced in the previous step and
the full XML-TEI files to be uploaded. 

Usage: The only parameter you should need to adjust is the path
encoded in the variable "collection" to be worked on. 
File preparation is one one language at a time. 

Output: The script writes a collection of files to the output folder for
the language collection concerned. 

Please send feedback to Christof at "schoech@uni-trier.de". 
"""




# === Import statements ===

import os
import re
import glob
from os.path import join
from os.path import basename
import pandas as pd
from collections import Counter
import lxml.etree as ET



# === Files and folders ===

collection = "ELTeC-fra"
level = "level1"



# === Helper functions ===


def read_metadatafile(metadatafile): 
    with open(metadatafile, "r", encoding="utf8") as infile: 
        metadata = pd.read_csv(infile, sep="\t", index_col="xmlid")
        #print(metadata.head())
    return metadata


def read_template(templateid):
    templatefile = join("templates", templateid)
    with open(templatefile, "r", encoding="utf8") as infile: 
        template = infile.read()
        return template


def save_template(template, language, templatefile): 
    outfolder = join("output", language)
    if not os.path.exists(outfolder): 
        os.makedirs(outfolder)
    with open(join("output", templatefile), "w", encoding="utf8") as outfile: 
        outfile.write(template)



# === Functions to fill template files: one per language ===


def fill_aggregation_meta(language):
    templatefile = "-LLL.aggregation.meta"
    template = read_template(join(templatefile))
    template = re.sub("LLL", language, template)
    templatefile = re.sub("LLL", language, templatefile)
    save_template(template, language, templatefile)
    

# TODO: "LLL.aggregation"



# === Functions to fill template files: one per text ===


def fill_LLLNNN_edition_meta(xmlfile, counter, language, metadata):
    # Read the empty templatefile
    templatefile = "LLLNNN.edition.meta"
    template = read_template(join("LLL", templatefile))
    template = re.sub("LLL", language, template)
    # Find information for the template
    identifier, rest = basename(xmlfile).split("_")
    author = metadata.loc[identifier, "author"]
    title = metadata.loc[identifier, "title"]
    # Fill information into the template
    template = re.sub("LLL", language, template)   
    template = re.sub("NNN", counter, template)   
    template = re.sub("#author#", author, template)   
    template = re.sub("#title#", title, template)   
    # Adapt the templatefile's filename
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)
    templatefile = join(language, templatefile)
    # Save the individual, filled-in templatefile
    save_template(template, language, templatefile)



# TODO: LLL/LLLNNN.edition

# TODO: LLL/LLLNNN/-LLLNNN.xml

# TODO: LLL/LLLNNN/-LLLNNN.xml.meta

# TODO: LLL/LLLNNN/LLLNNN.work

# TODO: LLL/LLLNNN/LLLNNN.work.meta



# === Main ===


def main(collection, level):
    language = collection[-3:].upper()
    metadatafile = join("metadata", collection+".tsv")
    metadata = read_metadatafile(metadatafile)
    xmlfiles = join("input", collection, level, "*.xml") 
    fill_aggregation_meta(language)
    counter  = 0
    for xmlfile in glob.glob(xmlfiles):
        counter +=1
        counter = "{:03}".format(counter)
        print(counter, basename(xmlfile))
        fill_LLLNNN_edition_meta(xmlfile, counter, language, metadata)
        counter = int(counter)

main(collection, level)


