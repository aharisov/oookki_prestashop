async function readXMLFile(filePath: string): Promise<void> {
    const response = await fetch(filePath);
    const text = await response.text();
    
    const parser = new DOMParser();
    const xmlDoc = parser.parseFromString(text, "text/xml");

    const productNode = xmlDoc.querySelector("product");
    
    if (productNode) {
        const id = productNode.querySelector("id")?.textContent?.trim();
        const manufacturerName = productNode.querySelector("manufacturer_name")?.textContent?.trim();
        const reference = productNode.querySelector("reference")?.textContent?.trim();
        const price = productNode.querySelector("price")?.textContent?.trim();
        const productName = productNode.querySelector("name language")?.textContent?.trim();
        const description = productNode.querySelector("description language")?.textContent?.trim();

        console.log("Product ID:", id);
        console.log("Manufacturer:", manufacturerName);
        console.log("Reference:", reference);
        console.log("Price:", price);
        console.log("Name:", productName);
        console.log("Description:", description);
    } else {
        console.error("No product data found.");
    }
}

// Usage example:
//readXMLFile("/response.xml");
