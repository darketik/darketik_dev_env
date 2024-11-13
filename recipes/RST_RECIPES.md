Example project: 

- https://github.com/riscv-mcu/e203_hbirdv2/blob/master/doc
- https://github.com/lowRISC/ibex/tree/master/doc
- Python doc generator
  - Sphinx:  https://www.sphinx-doc.org/en/master/
  - https://www.sphinx-doc.org/en/master/usage/index.html
- Doc description language
  - ReStructuredText    
    - https://docutils.sourceforge.io/docs/user/rst/quickref.html
      - https://docutils.sourceforge.io/docs/user/rst/quickstart.html
      - https://docutils.sourceforge.io/rst.html
      - https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#document
      - https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#rst-primer
      - https://sphinx-tutorial.readthedocs.io/cheatsheet/ 
      - https://docutils.sourceforge.io/docs/ref/rst/directives.html#body-elements
  - mySt (markdown extension)
    - https://myst-parser.readthedocs.io/en/latest/intro.html

- Highlighter
  - https://pygments.org/

- Doc description language processor
  - Docutils
    - https://pypi.org/project/docutils/

- Vnreiorv
  - https://readthedocs.org/

- Diagram and charting code
  - https://mermaid.js.org/
- Doxygen extension 
  - breathe: https://breathe.readthedocs.io/en/latest/autoindex.html
  - doxylink: https://sphinxcontrib-doxylink.readthedocs.io/en/stable/#

Workflow: rst file -> docutils -> sphinx -> HTML & PDF


Normally, there are no heading levels assigned to certain characters as the structure is determined from the succession of headings. However, this convention is used in Python Developer’s Guide for documenting which you may follow:

    # with overline, for parts

    * with overline, for chapters

    = for sections

    - for subsections

    ^ for subsubsections

    " for paragraphs
