package UI.Locales;

import Conexiones.Procedimientos;
import Sistema.Empleado;
import Sistema.Local;
import UI.Interface.Advertencia;
import UI.Interface.Application;
import UI.Misc.ScrollBar;
import UI.Table.TableActionCellEditor;
import UI.Table.TableActionCellRender;
import UI.Table.TableActionEvent;
import UI.Table.TableButtonCellEditor;
import UI.Table.TableButtonCellRender;
import UI.Table.TableButtonEvent;
import UI.Table.TableFilter;
import java.awt.Color;
import java.awt.GradientPaint;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.SQLException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.RowFilter;
import javax.swing.table.TableModel;
import javax.swing.table.TableRowSorter;

public class Locales extends javax.swing.JPanel {
    private Color color1;
    private Color color2;
    private final Application frame;
    private final TableRowSorter st;
    
    public Locales(Application frame) {
        initComponents();
        setOpaque(false);
        
        this.frame = frame;
        
        TableActionEvent event = new TableActionEvent() {
            @Override
            public void onEdit(int row) {
                EditLocal obj = new EditLocal();
                obj.setApplication(frame);
                obj.setIndex(row);
                obj.setLocal(frame.findLocalByCodigo((int) table.getValueAt(row, 0)));
                obj.initData();
                frame.setEnabled(false);
                obj.setVisible(true);
            }

            @Override
            public void onDelete(int row) {
                if (table.isEditing()) {
                    table.getCellEditor().stopCellEditing();
                }
                
                Advertencia obj = new Advertencia();
                frame.setEnabled(false);
                obj.setVisible(true);
                
                obj.getEliminar().addMouseListener(new MouseAdapter() {
                    @Override
                    public void mousePressed(MouseEvent me) {
                        try {
                            deleteLocal(row);
                        } 
                        catch (SQLException ex) {
                            JOptionPane.showMessageDialog(null, "El local está siendo referenciado en una venta.", "Error de Procedimiento", JOptionPane.ERROR_MESSAGE);
                        }
                        obj.dispose();
                        frame.setEnabled(true);
                    }
                });
                
                obj.getCancelar().addMouseListener(new MouseAdapter() {
                    @Override
                    public void mousePressed(MouseEvent me) {
                        obj.dispose();
                        frame.setEnabled(true);
                    }
                });
            }

            @Override
            public void onView(int row) {
                ViewLocal obj = new ViewLocal();
                obj.setLocal(frame.findLocalByCodigo((int) table.getValueAt(row, 0)));
                obj.setApplication(frame);
                obj.initData();
                frame.setEnabled(false);
                obj.setVisible(true);
            }
        };
        
        color1 = Color.WHITE;
        color2 = Color.GRAY;
        
        spTable.setVerticalScrollBar(new ScrollBar());
        spTable.getVerticalScrollBar().setBackground(Color.WHITE);
        spTable.getViewport().setBackground(Color.WHITE);
        JPanel p = new JPanel();
        p.setBackground(Color.WHITE);
        spTable.setCorner(JScrollPane.UPPER_RIGHT_CORNER, p);
        
        for (Local local : frame.getLocalesList()) {
            table.addRow(new Object[] { local.getCodigo(), local.getDireccion(), local.getTelefono(), "", "", "" });
        }

        table.getColumnModel().getColumn(5).setCellRenderer(new TableActionCellRender());
        table.getColumnModel().getColumn(5).setCellEditor(new TableActionCellEditor(event));
        
        st = new TableRowSorter(table.getModel());
        table.setRowSorter(st);
        
        search1.getSearchText().addKeyListener(new KeyAdapter() {
            @Override
            public void keyPressed(KeyEvent e) {
                if (e.getKeyCode() == KeyEvent.VK_ENTER) {
                    String[] filters = search1.getFilters();
                    st.setRowFilter(new TableFilter(filters) {
                        @Override
                        public boolean include(RowFilter.Entry<? extends TableModel, ? extends Integer> entry) {
                            return filterRow(entry, this, filters);
                        }
                    });
                }
            }
        });
        
        TableButtonEvent productos_event = (int row) -> {
            TableRowSorter<TableModel> sorter = (TableRowSorter<TableModel>) frame.getProductos().getTable().getRowSorter();
            String[] filter = new String[] { "local=" + String.valueOf((int) table.getValueAt(row, 0)) };
            
            sorter.setRowFilter(new TableFilter(filter) {
                @Override
                public boolean include(RowFilter.Entry<? extends TableModel, ? extends Integer> entry) {
                    return frame.getProductos().filterRow(entry, this, filter);
                }
            });
            
            frame.getProductos().getSearch().getSearchText().setText(filter[0]);
            frame.setForm(frame.getProductos());
            frame.getMenu().getListMenu().changeColor(3);
        };
        
        table.getColumnModel().getColumn(3).setCellRenderer(new TableButtonCellRender("productos", Color.WHITE, new Color(51, 51, 51, 255), new Color(230, 230, 230, 255)));
        table.getColumnModel().getColumn(3).setCellEditor(new TableButtonCellEditor(productos_event, "productos"));
        
        TableButtonEvent empleados_event = (int row) -> {
            TableRowSorter<TableModel> sorter = (TableRowSorter<TableModel>) frame.getEmpleados().getTable().getRowSorter();
            String[] filter = new String[] { "local=" + String.valueOf((int) table.getValueAt(row, 0)) };
            
            sorter.setRowFilter(new TableFilter(filter) {
                @Override
                public boolean include(RowFilter.Entry<? extends TableModel, ? extends Integer> entry) {
                    return frame.getEmpleados().filterRow(entry, this, filter);
                }
            });
            
            frame.getEmpleados().getSearch().getSearchText().setText(filter[0]);
            frame.setForm(frame.getEmpleados());
            frame.getMenu().getListMenu().changeColor(2);
        };
        
        table.getColumnModel().getColumn(4).setCellRenderer(new TableButtonCellRender("empleados", Color.WHITE, new Color(51, 51, 51, 255), new Color(230, 230, 230, 255)));
        table.getColumnModel().getColumn(4).setCellEditor(new TableButtonCellEditor(empleados_event, "empleados"));
        
        table.getColumnModel().getColumn(0).setPreferredWidth(20);
        table.getColumnModel().getColumn(1).setPreferredWidth(200);
        table.getColumnModel().getColumn(2).setPreferredWidth(60);
        table.getColumnModel().getColumn(3).setPreferredWidth(20);
        table.getColumnModel().getColumn(4).setPreferredWidth(20);
        table.getColumnModel().getColumn(5).setPreferredWidth(40);
    }
    
    public boolean filterRow(RowFilter.Entry<? extends TableModel, ? extends Integer> entry, TableFilter table_filter, String[] filters) {
        TableModel model = entry.getModel();
        int row_index = entry.getIdentifier();
        Local local = frame.findLocalByCodigo((int) model.getValueAt(row_index, 0));
        Pattern pattern = Pattern.compile("^([a-zA-Z]+)([<>]=?|!=|=)(.+)$");
        Pattern pattern2 = Pattern.compile("^(\\\".*\\\"|[a-zA-Z0-9]+)$");
        int count;

        for (String filter : filters) {
            Matcher matcher = pattern.matcher(filter);
            Matcher matcher2 = pattern2.matcher(filter);

            if (matcher.find()) {
                String field = matcher.group(1);
                String comparator = matcher.group(2);
                String find_this = matcher.group(3);

                switch (field) {
                    case "codigo", "código" -> {
                        try {
                            int comparado = Integer.parseInt(find_this);
                            int original = local.getCodigo();
                            
                            if (!frame.compareFilter(original, comparado, comparator)) return false;
                        }
                        catch (NumberFormatException e) {
                            return false;
                        }
                    }
                    case "direccion" -> {
                        String comparado = find_this.replaceAll("\"", "");
                        String original = local.getDireccion();
                        if (!frame.compareFilter(original, comparado, comparator)) return false;
                    }
                    case "telefono" ->                         {
                        String comparado = find_this.replaceAll("\"", "");
                        String original = local.getTelefono();
                        
                        if (!frame.compareFilter(original, comparado, comparator)) return false;
                    }
                    case "comentario" -> {
                        String comparado = find_this.replaceAll("\"", "");
                        String original = local.getComentario();
                        
                        if (!frame.compareFilter(original, comparado, comparator)) return false;
                    }
                    case "producto" -> {
                        try {
                            int comparado = Integer.parseInt(find_this);
                            
                            if (comparator.equals("=") || comparator.equals("!=")) {
                                if (comparator.equals("=") && !local.getProductos().contains(comparado)) return false; 
                                if (comparator.equals("!=") && local.getProductos().contains(comparado)) return false;
                            }
                            else return false;
                        }
                        catch (NumberFormatException e) {
                            String comparado = find_this.replaceAll("\"", "");
                            String original;
                            count = 0;
                            
                            for (Integer producto : local.getProductos()) {
                                original = frame.findProductoByCodigo(producto).getNombre();
                                if (frame.compareFilter(original, comparado, comparator)) count++;
                            }
                            
                            if (count == 0) return false;
                        }
                    }
                    case "empleado" -> {
                        String comparado = find_this.replaceAll("\"", "");
                        String original;
                        count = 0;

                        for (String empleado : local.getEmpleados()) {
                            original = empleado + " " + frame.findEmpleadoByDNI(empleado).getNombresApellidos();
                            if (frame.compareFilter(original, comparado, comparator)) count++;
                        }

                        if (count == 0) return false;
                    }
                    default -> {
                        return false;
                    }
                }
            }
            else if (matcher2.find()) {
                String find_this = matcher2.group(1);
                find_this = find_this.replaceAll("\"", "");
                count = 0;

                for (int i = 0; i < entry.getValueCount(); i++) {
                    if (entry.getStringValue(i).contains(find_this)) count++;
                }
                
                if (count == 0) return false; 
            }
            else if (filter.equals("")) {} 
            else return false;
        }

        return true;
    }
    
    public Color getColor1() {
        return color1;
    }

    public void setColor1(Color color1) {
        this.color1 = color1;
    }

    public Color getColor2() {
        return color2;
    }

    public void setColor2(Color color2) {
        this.color2 = color2;
    }
    
    public void addLocal(Local local) throws SQLException {
        int local_codigo = Procedimientos.addLocal(local);
        Procedimientos.updateLocalesEmpleados(frame.getEmpleadosList());
        
        local.setCodigo(local_codigo);
        frame.getLocalesList().add(local);
        table.addRow(new Object[] { local.getCodigo(), local.getDireccion(), local.getTelefono(), "", "", "" });
    }
    
    public void updateLocal(int row, Local local) throws SQLException {
        Local local_original = frame.findLocalByCodigo(local.getCodigo());
        
        if (local_original != null) {
            Procedimientos.updateLocal(local);
            Procedimientos.updateLocalesEmpleados(frame.getEmpleadosList());
            
            local_original.setDireccion(local.getDireccion());
            local_original.setTelefono(local.getTelefono());
            local_original.setComentario(local.getComentario());
            local_original.setProductos(local.getProductos());
            
            table.setValueAt(local.getCodigo(), row, 0);
            table.setValueAt(local.getDireccion(), row, 1);
            table.setValueAt(local.getTelefono(), row, 2);
        }
    }
    
    public void deleteLocal(int row) throws SQLException {
        Local local = frame.findLocalByCodigo((int) table.getValueAt(row, 0));
        Procedimientos.deleteLocal(local);
        
        for (Empleado empleado : frame.getEmpleadosList()) {
            if (empleado.getLocalAsignado() != null) {
                if (empleado.getLocalAsignado() == local.getCodigo()) empleado.setLocalAsignado(null);
            }
        }
        
        frame.getLocalesList().remove(local);
        table.removeRow(row);
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        search1 = new UI.Misc.Search();
        background = new UI.Misc.SimpleBackground();
        jLabel1 = new javax.swing.JLabel();
        addButton1 = new UI.Misc.CustomButton();
        spTable = new javax.swing.JScrollPane();
        table = new UI.Table.Table();

        setBackground(new java.awt.Color(204, 204, 204));
        setOpaque(false);

        background.setBackground(new java.awt.Color(255, 255, 255));

        jLabel1.setFont(new java.awt.Font("sansserif", 1, 24)); // NOI18N
        jLabel1.setForeground(new java.awt.Color(102, 102, 102));
        jLabel1.setText("Locales");

        addButton1.setBackground(new java.awt.Color(51, 153, 255));
        addButton1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/Icons/plus.png"))); // NOI18N
        addButton1.setBorderColor(new java.awt.Color(255, 255, 255));
        addButton1.setColor(new java.awt.Color(51, 153, 255));
        addButton1.setColorClick(new java.awt.Color(39, 81, 122));
        addButton1.setColorOver(new java.awt.Color(56, 127, 198));
        addButton1.setRadius(50);
        addButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                addButton1ActionPerformed(evt);
            }
        });

        spTable.setBorder(null);

        table.setBackground(new java.awt.Color(255, 255, 255));
        table.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Código", "Dirección", "Teléfono", "", "", ""
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Integer.class, java.lang.String.class, java.lang.String.class, java.lang.Object.class, java.lang.Object.class, java.lang.Object.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, true, true, true
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        spTable.setViewportView(table);

        javax.swing.GroupLayout backgroundLayout = new javax.swing.GroupLayout(background);
        background.setLayout(backgroundLayout);
        backgroundLayout.setHorizontalGroup(
            backgroundLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(backgroundLayout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addGroup(backgroundLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(spTable)
                    .addGroup(backgroundLayout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(662, 662, 662)
                        .addComponent(addButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 40, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(20, Short.MAX_VALUE))
        );
        backgroundLayout.setVerticalGroup(
            backgroundLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(backgroundLayout.createSequentialGroup()
                .addGap(16, 16, 16)
                .addGroup(backgroundLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addComponent(addButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 39, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(spTable, javax.swing.GroupLayout.PREFERRED_SIZE, 394, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(20, Short.MAX_VALUE))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(search1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
            .addGroup(layout.createSequentialGroup()
                .addGap(25, 25, 25)
                .addComponent(background, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(search1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(41, 41, 41)
                .addComponent(background, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 39, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void addButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_addButton1ActionPerformed
        AddLocal obj = new AddLocal();
        obj.setApplication(frame);
        frame.setEnabled(false);
        obj.setVisible(true);
    }//GEN-LAST:event_addButton1ActionPerformed
    
    @Override
    protected void paintComponent(Graphics graphics) {
        Graphics2D g2 = (Graphics2D) graphics;
        g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        GradientPaint g = new GradientPaint(0, 0, color1, 0, getHeight(), color2);
        g2.setPaint(g);
        g2.fillRoundRect(0, 0, getWidth(), getHeight(), 15, 15);
        g2.fillRect(0, 0, 20, getHeight());
        g2.setColor(new Color(255, 255, 255, 50));
        super.paintComponent(graphics);
    }
    
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private UI.Misc.CustomButton addButton1;
    private UI.Misc.SimpleBackground background;
    private javax.swing.JLabel jLabel1;
    private UI.Misc.Search search1;
    private javax.swing.JScrollPane spTable;
    private UI.Table.Table table;
    // End of variables declaration//GEN-END:variables
}
