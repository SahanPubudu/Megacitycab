<%@ page import="com.itextpdf.text.*" %>
<%@ page import="com.itextpdf.text.pdf.*" %>

<%
    // Retrieve form data from the submitted form
    String fullName = request.getParameter("full_name");
    String address = request.getParameter("address");
    String nic = request.getParameter("nic");
    String phone = request.getParameter("phone");
    String email = request.getParameter("email");
    String fromLocation = request.getParameter("from_location");
    String toLocation = request.getParameter("to_location");
    String vehicleModel = request.getParameter("vehicle_model");
    String rentPrice = request.getParameter("rent_price");

    try {
        // Create PDF document
        Document document = new Document(PageSize.A4);
        
        // Set content type to PDF
        response.setContentType("application/pdf");
        
        // Suggest to the browser that the content should be downloaded as an attachment
        response.setHeader("Content-Disposition", "attachment; filename=\"ticket.pdf\"");
        
        // Create a PDF writer that writes to the response output stream
        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
        
        // Open the document to write content
        document.open();
        
        // Add a custom header with a logo and title
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, BaseColor.BLACK);
        Paragraph title = new Paragraph("MegaCityCab Booking Receipt", titleFont);
        title.setAlignment(Element.ALIGN_CENTER);
        document.add(title);
        
        // Add a custom line separator using Chunk
        document.add(new Chunk("---------------------------------------------------"));
        
        // Add some space
        document.add(Chunk.NEWLINE);
        
        // Add receipt heading
        Font sectionFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.BLACK);
        Paragraph detailsHeading = new Paragraph("Booking Details", sectionFont);
        detailsHeading.setAlignment(Element.ALIGN_LEFT);
        document.add(detailsHeading);
        
        // Add booking details inside a styled table
        PdfPTable table = new PdfPTable(2); // Two columns for field and value
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);
        
        // Add headers with bold style and background color
        PdfPCell cell = new PdfPCell(new Phrase("Field", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(new BaseColor(37, 117, 252)); // Blue background
        table.addCell(cell);
        cell = new PdfPCell(new Phrase("Details", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.WHITE)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setBackgroundColor(new BaseColor(37, 117, 252)); // Blue background
        table.addCell(cell);
        
        // Add data to the table with padding and borders
        Font dataFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);
        
        table.addCell(createCell("Full Name:", dataFont));
        table.addCell(createCell(fullName, dataFont));
        
        table.addCell(createCell("Address:", dataFont));
        table.addCell(createCell(address, dataFont));
        
        table.addCell(createCell("NIC:", dataFont));
        table.addCell(createCell(nic, dataFont));
        
        table.addCell(createCell("Phone:", dataFont));
        table.addCell(createCell(phone, dataFont));
        
        table.addCell(createCell("Email:", dataFont));
        table.addCell(createCell(email, dataFont));
        
        table.addCell(createCell("From Location:", dataFont));
        table.addCell(createCell(fromLocation, dataFont));
        
        table.addCell(createCell("To Location:", dataFont));
        table.addCell(createCell(toLocation, dataFont));
        
        table.addCell(createCell("Vehicle Model:", dataFont));
        table.addCell(createCell(vehicleModel, dataFont));
        
        table.addCell(createCell("Rent Price:", dataFont));
        table.addCell(createCell("LKR " + rentPrice, dataFont));
        
        // Add the table to the document
        document.add(table);
        
        // Add some space
        document.add(Chunk.NEWLINE);
        
        // Add footer with "Thank you" message
        Font footerFont = FontFactory.getFont(FontFactory.HELVETICA, 10, BaseColor.GRAY);
        Paragraph footer = new Paragraph("Thank you for booking with MegaCityCab! Enjoy your trip!", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);
        
        // Close the document to complete the PDF
        document.close();
    } catch (Exception e) {
        // Handle any errors during PDF generation
        e.printStackTrace();
        out.println("<script>alert('Error generating ticket. Try again.'); window.history.back();</script>");
    }
%>

<%!
    // Helper method to create a styled cell
    private PdfPCell createCell(String text, Font font) {
        PdfPCell cell = new PdfPCell(new Phrase(text, font));
        cell.setPadding(8);
        cell.setBorderColor(BaseColor.LIGHT_GRAY);
        return cell;
    }
%>