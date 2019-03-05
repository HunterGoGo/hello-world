package cc.cho;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class JavaTransformXsl {
	
	private static Element buildElement(Document doc, Element rootelem, String elemvalue, String attr, String value) throws Exception {
		Element element = doc.createElement(elemvalue);
		
		if (rootelem == null) {
			doc.appendChild(element);
		} else {
			rootelem.appendChild(element);
		}
		
		if (attr != null && !"".equals(attr)) {
			element.setAttribute(attr, value);
		}
		
		return element;
	}

	public static void main(String[] args) {
		
		try {
			DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuilder = docFactory.newDocumentBuilder();
			
			// 루트 엘리먼트
			Document doc = docBuilder.newDocument();
			// standalone="no" 속성 삭제
			doc.setXmlStandalone(true);
			// Element rootElement = doc.createElement("xsl:stylesheet");
			// doc.appendChild(rootElement);
			// rootElement.setAttribute("xmlns:xsl", "http://www.w3.org/TR/WD-xsl");
			Element rootElement = buildElement(doc, null, "xsl:stylesheet", "xmlns:xsl", "http://www.w3.org/TR/WD-xsl");
			Element sub = buildElement(doc, rootElement, "xsl:template", "match", "*");
			buildElement(doc, sub, "xsl:apply-templates", "", "");
			Element sub1 = buildElement(doc, rootElement, "xsl:template", "match", "text()");
			buildElement(doc, sub1, "xsl:value-of", "select", ".");
			
			// template match="*" 엘리먼트
			// Element template1 = doc.createElement("xsl:template");
			// rootElement.appendChild(template1);
			// template1.setAttribute("match", "*");
			
			// appply-templates 엘리먼트
			// Element apply_templates = doc.createElement("xsl:apply-templates");
			// template1.appendChild(apply_templates);
			
			// template match="text()" 엘리먼트
			// Element template2 = doc.createElement("xsl:template");
			// rootElement.appendChild(template2);	
			// template2.setAttribute("match", "text()");
			
			// value-of select="." 엘리먼트
			// Element value_of = doc.createElement("xsl:value-of");
			// template2.appendChild(value_of);
			// value_of.setAttribute("select", ".");

			// XSL 파일로 쓰기
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			
			transformer.setOutputProperty(OutputKeys.DOCTYPE_PUBLIC, "");
			transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
			transformer.setOutputProperty(OutputKeys.INDENT, "yes");
			transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");
			DOMSource source = new DOMSource(doc);
			// 파일로 저장
			// StreamResult result = new StreamResult(new FileOutputStream(new File("file.xsl")));
			
			// 파일로 쓰지 않고 콘솔에 찍어보고 싶을 경우 다음을 사용 (디버깅용)
			StreamResult result = new StreamResult(System.out);
			
			transformer.transform(source, result);
			// System.out.println("File saved");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
