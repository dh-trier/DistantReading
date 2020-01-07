import xml.etree.ElementTree as ETree
from lxml import etree


#----------------------------------------------------------------#
# Mapping data labels to tags; labels provide a unique set of keys for the
# tags, some of which (like title) occur multiply, in different paths
labeltag_mapping \
 = { "genTitle" : "title" # title in /object/generic/provided path
   , "genAuthor" : "author" # ditto author
   , "id" : "id"
   , "lang" : "lang"
   , "edTitle" : "title" # title in /object/edition path
   , "edAuthor" : "author"  # ditto author
   , "edPublisher" : "publisher"
   , "edDate" : "date"
   , "licence" : "licence"
   , "licenceUri": "licence" # licence with URI attribute
   }

# Prepare data container, one slot for each label:tag pair
data = {}
for k in labeltag_mapping.keys():
    data[k] = ""

#----------------------------------------------------------------#
# Auxiliaries
def stripprefix(s): # Should be replaced by suitable tool from libraries
  pos = s.index("}")
  if pos >= 0:
    t = s[pos+1:len(s)]
    if len(t) > 0:
      return t
  return s

#----------------------------------------------------------------#

inputfilename = "tei-input_chen.xml"
outputfilename = "grid-output_chen.xml"

#================================================================#
# Ideally the "converter" would alternate parse and write, i.e.:
# - Apply xpath search successively to each full TEI-tag path in the
#   source XML and collect the corresponding text item
# - Write out the corresponding full TextGrid-tag path in the target
#   XML with the text item

# Working versions collect required data by visiting all nodes of the XML tree
# and then generate output

#================================================================#
# TEI XML parser
# Use ElementTree

tree = ETree.iterparse(inputfilename, events=('start', 'end'))  # default is end events only

titleStmt = 0
sourceDesc = 0
# Use iteration and remember some relevant parts of parent path only
for event, node in tree:
    utag = stripprefix(node.tag)
    if node.text is not None: text = (node.text).strip()
    if (node.tag).endswith("sourceDesc"):
        if event == "start":
            titleStmt = 1
        elif event == "end":
            titleStmt = 0
    elif (node.tag).endswith("titleStmt"):
        if event == "start":
            sourceDesc = 1
        elif event == "end":
            sourceDesc = 0
    elif event == "start":
        if (node.tag).endswith("title"):
            if titleStmt == 1:
                data["genTitle"] = node.text
            elif sourceDesc == 1:
                data["edTitle"] = node.text
        elif (node.tag).endswith("author"):
            if titleStmt == 1:
                data["genAuthor"] = node.text
            elif sourceDesc == 1:
                data["edAuthor"] = node.text
        else:
            for k, v in labeltag_mapping.items():
                if k.endswith("Title") or k.endswith("Author"): continue
                if data[k] == "" and (node.tag).endswith(v):
                    data[k] = text
                    break
print(data)

#================================================================#
# Text2Grid XML writer
# Use dataset {title, author, ...} from TEI style XML to create TextGrid one

TEXTGRID_NS_URL = "http://textgrid.info/namespaces/metadata/core/2010"
TEXTGRID_NS_FMT = "{%s}" % TEXTGRID_NS_URL

root_tag = etree.Element("object")
root_tag.set("xmlns", TEXTGRID_NS_FMT)
root_tag.set("xmlns-tg", "http://textgrid.info/relation-ns#")  # should be xmlns:tg
root_tag.set("xmlns-rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#")  # should be xmlns:rdf
root_tag = etree.Element(TEXTGRID_NS_FMT + "object")
generic_tag = etree.SubElement(root_tag, "generic")
provided_tag = etree.SubElement(generic_tag, "provided")
genTitle_tag = etree.SubElement(provided_tag, "title")
format_tag = etree.SubElement(provided_tag, "format")

genTitle_tag.text = data["genTitle"]
format_tag.text = "text/tg.edition+tg.aggregation+xml"

edition_tag = etree.SubElement(root_tag, "edition")
isEditionOf_tag = etree.SubElement(edition_tag, "isEditionOf")
agent_tag = etree.SubElement(edition_tag, "agent")

isEditionOf_tag.text = "PATH OF FILE.work"
agent_tag.text = data["edAuthor"]

source_tag = etree.SubElement(edition_tag, "source")
bibCit_tag = etree.SubElement(source_tag, "bibliographicCitation")
edTitle_tag = etree.SubElement(bibCit_tag, "editionTitle")
edAuthor_tag = etree.SubElement(bibCit_tag, "author")
edDate_tag = etree.SubElement(bibCit_tag, "dateOfPublication")

edTitle_tag.text = data["edTitle"]
edAuthor_tag.text = data["edAuthor"]
edDate_tag.text = data["edDate"]

notation_tag = etree.SubElement(edition_tag, "formOfNotation")
language_tag = etree.SubElement(edition_tag, "language")
license_tag = etree.SubElement(edition_tag, "license")

notation_tag.text = "Latin"
language_tag.text = data["lang"]
license_tag.text = data["licence"]

# print(etree.tostring(root_tag, pretty_print=True))  # screen check
with open(outputfilename, "w") as g:  # print to file
    g.write("<?xml version='1.0' encoding='UTF-8'?>\n")
    g.write(etree.tostring(root_tag, pretty_print=True, encoding="unicode"))