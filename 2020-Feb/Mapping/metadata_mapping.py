#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Script to extract selected metadata from the ELTeC teiHeader 
and use it to build TextGrid Object metadata files from it. 
"""

# ===== Import statements =====

import lxml
from lxml import etree as et
from os.path import join
from os.path import basename


# ===== Files and folders =====

wdir = ""
# fetch language ID and work IDS #
drf = join(wdir, "drf", "ENG18652.xml")
wmtf = join(wdir, "tgt", "DEU", "DEU001", "template.work.meta")
wmf = join(wdir, "tgf", "DEU", "DEU001", "ENG18652.work.meta")
namespaces = {"tei":"http://www.tei-c.org/ns/1.0"}


# ===== Functions =====

def read_xml(xmlfile): 
    """
    Reads an XML file and returns it as an LXML object.
    """
    print("--read_xml")
    print(" ", basename(xmlfile))
    xml = et.parse(xmlfile).getroot()
    return xml


def copy_author(dr, namespaces, wmt): 
    """
    Extracts one piece of metadata (author name) from the teiHeader of
    the original ELTeC text. 
    Locates the right place in the "work.meta" template file (agent)
    and adds the author name as text into that element. 
    Returns the modified work.meta object.
    """
    print("--copy_author")
    author = dr.xpath("//tei:titleStmt/tei:author//text()", namespaces=namespaces)[0]
    agent = wmt.xpath("//agent")[0]
    agent.text = author
    print(et.tostring(wmt))    
    return wmt


def copy_title(dr, namespaces, wmt): 
    print("--copy_title")
    dr_title = dr.xpath("//tei:titleStmt/tei:title//text()", namespaces=namespaces)[0]
    wmt_title = wmt.xpath("//title")[0]
    wmt_title.text = dr_title
    #print(et.tostring(wmt))    
    return wmt


def write_wmfile(wmt, wmf): 
    """
    Saves the resulting Element Tree object to the work.meta file. 
    """
    print("--write_xmlfile")
    print(" ", basename(wmf))
    wmt = et.ElementTree(wmt)
    wmt.write(wmf)


# ===== Main function =====


def main(drf, wmtf, wmf, namespaces): 
    """
    Coordinates the process. 
    """
    wmt = read_xml(wmtf)
    dr = read_xml(drf)
    wmt = copy_author(dr, namespaces, wmt)
    wmt = copy_title(dr, namespaces, wmt)
    write_wmfile(wmt, wmf)

main(drf, wmtf, wmf, namespaces)

