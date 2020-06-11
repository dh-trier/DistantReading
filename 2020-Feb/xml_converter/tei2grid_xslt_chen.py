import os
import lxml.etree as ET
from os.path import join

""" need to duplicate all backslashes:"""
# inputpath = "D:\\temp\\"
# xsltfile = "D:\\temp\\test.xsl"
# outpath = "D:\\output"
"""Or prefix the string with r (to produce a raw string):"""
"""Full Path, the following is just an example"""

inputpath = join("", "XML", "")
xsltfile = join("", "workMetaGenerierung.xsl")
outpath = join("", "grid_output_py_xslt", "")

for dirpath, dirnames, filenames in os.walk(inputpath):
  for filename in filenames:
    if filename.endswith(('.xml', '.txt')):
      dom = ET.parse(inputpath + filename)
      xslt = ET.parse(xsltfile)
      transform = ET.XSLT(xslt)
      newdom = transform(dom)
      infile = (ET.tostring(newdom, pretty_print=True, encoding="unicode"))
      outfile = open(join(outpath, filename), 'w')
      outfile.write(infile)
