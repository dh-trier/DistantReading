import os
import itertools
import lxml.etree as ET
import re
from os.path import join
import glob


wdir = ""
#inpath =  os.path.join("home", "christof", "repos", "dh-trier", "Distant-Reading", "Testdataset", "XML", "")
inpath = join(wdir, "..", "..", "Testdataset", "XML", "DEU", "")
outpath = os.path.join("", "Testoutput", "")
xsltpath = os.path.join("", "xslt_files", "")



for dirpath, dirnames, filenames in os.walk(inpath):
    for filename in filenames:
        basename = filename.split(".")[0] # Removes [.xml] filename extension
        print(basename)
        prefix = basename.split("_")[0] # Removes [_author name] in the filename, e.g. DEU001_Willkommen ---> DEU001
        
        lang = "".join(itertools.takewhile(str.isalpha, prefix)) # Takes only characters in identifiers, e.g. DEU001 ---> DEU
        langdir = os.path.join(outpath, lang) # Creates aggregation folders
        filedir = os.path.join(langdir, prefix)

        aggr_file = os.path.join(outpath, "-" + lang + ".aggregation")
        aggr_meta_file = os.path.join(outpath, "-" + lang + ".aggregation.meta")
        edit_file = os.path.join(langdir, prefix + ".edition")
        edit_meta_file = os.path.join(langdir, prefix + ".edition.meta")
        work_file = os.path.join(filedir, prefix + ".work")
        work_meta_file = os.path.join(filedir, prefix + ".work.meta")
        xml_file = os.path.join(filedir, "-" + prefix + ".xml")
        xml_meta_file = os.path.join(filedir, "-" + prefix + ".xml.meta")
        
        for newdir in [langdir, filedir]:
            try:
                os.makedirs(newdir)
            except:
                if not os.path.isdir(newdir):
                    raise

        for outfile in [aggr_file, aggr_meta_file, edit_file, edit_meta_file, work_file, work_meta_file, xml_file, xml_meta_file]:
            print(outfile)
            suffix = outfile.split(".")[1:3]
            suffix = ".".join(suffix)
            print("===suffix===")
            print(suffix)


            for dirpath, dirnames, xslt_filenames in os.walk(xsltpath):
                for xslt_filename in xslt_filenames:
                    xslt_basename = re.sub(r'(.xsl)',"", xslt_filename)
                    print("===xsl basename")
                    print(xslt_basename)
                    if suffix == xslt_basename:
                        print("Here begins the transformation")

                        dom = ET.parse(inpath + filename)
                        xslt = ET.parse(xsltpath + xslt_filename)
                        transform = ET.XSLT(xslt)
                        newdom = transform(dom)
                        infile = (ET.tostring(newdom, pretty_print=True, encoding="unicode"))
                        outfile = open(outfile, 'w')
                        outfile.write(infile)
                        break
