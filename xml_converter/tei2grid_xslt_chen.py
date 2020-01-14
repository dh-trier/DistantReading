import os
import lxml.etree as ET

""" need to duplicate all backslashes:"""
# inputpath = "D:\\temp\\"
# xsltfile = "D:\\temp\\test.xsl"
# outpath = "D:\\output"
"""Or prefix the string with r (to produce a raw string):"""
"""Full Path, the following is just an example"""
inputpath = r"C:\Users\..\..\..\DistantReading\xml_converter\XML\\"
xsltfile = r"C:\Users\..\..\..\DistantReading\xml_converter\workMetaGenerierung.xsl"
outpath = r"C:\Users\..\..\..\DistantReading\xml_converter\grid_output_py_xslt"
for dirpath, dirnames, filenames in os.walk(inputpath):
  for filename in filenames:
    if filename.endswith(('.xml', '.txt')):
      dom = ET.parse(inputpath + filename)
      xslt = ET.parse(xsltfile)
      transform = ET.XSLT(xslt)
      newdom = transform(dom)
      infile = (ET.tostring(newdom, pretty_print=True, encoding="unicode"))
      outfile = open(outpath + "\\" + filename, 'a')
      outfile.write(infile)