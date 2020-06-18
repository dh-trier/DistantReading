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
from bs4 import BeautifulSoup as soup



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


def save_template(template, language, templatefile, outputlevel): 
    # saves all files
    # outputlevel creates the correct folder directory for each file
    new_folder = templatefile.split(".")[0]
    new_folder = re.sub("-", "", new_folder)
    #print(new_folder)
    
    outfolder0 = "output"
    outfolder1 = join("output", language)
    #print(templatefile)
    outfolder2 = join("output", language, new_folder)
    #print(outfolder2)
    if not os.path.exists(outfolder1): 
        os.makedirs(outfolder1)
    
    if outputlevel == 0:
        path = outfolder0
    elif outputlevel == 1:
        path = outfolder1
    elif outputlevel == 2:
        if not os.path.exists(outfolder2):
            os.makedirs(outfolder2)
        path = outfolder2
    else:
        print("Something went wrong with directories.")

    with open(join(path, templatefile), "w", encoding="utf8") as outfile: 
        outfile.write(template)
    

# === Functions to fill template files: one per language ===


def fill_aggregation_meta(language):
    templatefile = "-LLL.aggregation.meta"
    template = read_template(join(templatefile))
    template = re.sub("LLL", language, template)
    templatefile = re.sub("LLL", language, templatefile)
    save_template(template, language, templatefile, 0)
    


def fill_LLL_aggregation(language, aggregation_list):
    # fills the LLL.aggregation-file using a list of all edition-files
    # Read the emtpy template-file
    templatefile = "-LLL.aggregation"
    template = read_template(join(templatefile))
    # Changes filename and description-tag
    templatefile = re.sub("LLL", language, templatefile)
    template = re.sub('<rdf:Description rdf:about="-LLL.aggregation">', '<rdf:Description rdf:about="-{}.aggregation">'.format(language), template)
    #print(template)
    
    # parses the file as bs4-object and fills in each rdf_resource, i.e. edition used
    template = soup(template, "xml")
    
    for ed in aggregation_list:  
        rdf_tag = template.find({"rdf:Description"})
        new_tag = template.new_tag("ore:aggregates")
        new_tag.attrs["rdf:resource"]="{}/{}".format(language, ed)
        new_tag.append("")
        rdf_tag.append(new_tag)

    template = template.prettify()
    #print(template)
    # save file
    save_template(str(template), language, templatefile, 0)
    

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
    
    #templatefile = join(language, templatefile)
    # Save the individual, filled-in templatefile
    save_template(template, language, templatefile, 1)


def fill_LLL_LLLNNN_edition(xmlfile, counter, language):
    # Read the empty templatefile
    templatefile = "LLLNNN.edition"
    template = read_template(join("LLL", templatefile))
    # Fill information into the template
    template = re.sub("LLL", language, template)
    template = re.sub("NNN", counter, template)
    # Adapt the templatefile's filename
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)
    # Save the individual, filled-in templatefile
    save_template(template, language, templatefile, 1)
    
    
def fill_LLL_LLLNNN_xml(xmlfile, counter, language):
    # get template-file-name
    templatefile = "-LLLNNN.xml"
    # read the xml-file
    with open(xmlfile, "r", encoding="utf8") as infile:
        template = infile.read()
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)
    # save xml-file
    save_template(template, language, templatefile, 2)


def fill_LLL_LLLNNN_xml_meta(xmlfile, counter, language, metadata):
    # read emtpy template-file 
    templatefile = "-LLLNNN.xml.meta"
    template = read_template(join("LLL", "LLLNNN", templatefile))
    # Find information for the template
    identifier, rest = basename(xmlfile).split("_")
    title = metadata.loc[identifier, "title"]
    # Fill information into the template
    template = re.sub("#title#", title, template)
    # Adapt the templatefile's filename
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)

    save_template(template, language, templatefile, 2)


def fill_LLL_LLLNNN_work(xmlfile, counter, language):
    # read empty template-file
    templatefile = "LLLNNN.work"
    template = read_template(join("LLL", "LLLNNN", templatefile))
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)

    save_template(template, language, templatefile, 2)


def fill_LLL_LLLNNN_work_meta(xmlfile, counter, language, metadata):
    templatefile = "LLLNNN.work.meta"
    template = read_template(join("LLL", "LLLNNN", templatefile))
    # Find information for the template
    identifier, rest = basename(xmlfile).split("_")
    author = metadata.loc[identifier, "author"]
    title = metadata.loc[identifier, "title"]
    firstedition = metadata.loc[identifier, "firstedition"]
    # TODO extract gnd metadata
    # Fill information into the template
    template = re.sub("#author#", author, template)
    template = re.sub("#title#", title, template)
    template = re.sub("#firstedition#", str(firstedition), template)
    # TODO fill in gnd metadata or delete id
    # Adapt the templatefile's filename
    templatefile = re.sub("LLL", language, templatefile)
    templatefile = re.sub("NNN", counter, templatefile)

    save_template(template, language, templatefile, 2)

# === Main ===


def main(collection, level):
    language = collection[-3:].upper()
    metadatafile = join("metadata", collection+".tsv")
    metadata = read_metadatafile(metadatafile)
    xmlfiles = join("input", collection, level, "*.xml")
    fill_aggregation_meta(language)
    # TODO: "fill_LLL_aggregation" --> ich
    counter  = 0
    for xmlfile in glob.glob(xmlfiles):
        #print(xmlfile)
        counter +=1
        counter = "{:03}".format(counter)
        print(counter, basename(xmlfile))
        fill_LLLNNN_edition_meta(xmlfile, counter, language, metadata)
        fill_LLL_LLLNNN_edition(xmlfile, counter, language)
        fill_LLL_LLLNNN_xml(xmlfile, counter, language)
        fill_LLL_LLLNNN_xml_meta(xmlfile, counter, language, metadata)
        fill_LLL_LLLNNN_work(xmlfile, counter, language)
        fill_LLL_LLLNNN_work_meta(xmlfile, counter, language, metadata)
        counter = int(counter)
    
    # creates a list of all current edition-files in folder output/LLL/*.edition
    aggregation_files_list = []
    aggregation_files_path = join("output", language, "*.edition")
    for file in glob.glob(aggregation_files_path):
        #print(file)
        aggregation_files_list.append(basename(file))
    fill_LLL_aggregation(language, aggregation_files_list)
main(collection, level)


