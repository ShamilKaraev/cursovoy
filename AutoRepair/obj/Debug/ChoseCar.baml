   M S B A M L   `   `   `  ����E  AAutoRepair, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null'clr-namespace:AutoRepair
AutoRepair  5   	       AutoRepair.ChoseCar   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   *localclr-namespace:AutoRepair     5   	     � Title$  ChoseCar��5   	   $	��450��6   $	��800��6'   .��5	      � .+�5
   
   �� -   5         ��Name$ 	brand_lab��5
      $��
Марка��6#   $
��Left=�63   $��286,138,0,0q�6N   $	��Top=�6c   $	��113��6{   $��24��6�   $y�Hidden=�6�   �� 5   
   -   5        $ car_plate_lab��5      $��Рег. знак��6'   $
��Left=�6;   $��286,167,0,0q�6V   $	��Top=�6k   $	��113��6�   $��24��6�   $y�Hidden=�6�   �� 5   
   -   5         ��Name$ car_plate_text��5      $
��Left=�6*   $��24��6E   $��399,167,0,0q�6Q    �� TextWrapping$
 Wrap=�6f   $	��Top=�6z   $	��120��6�   $y�Hidden=�6�   �� 5   
   -   5        $ vin_lab��5      $��vin-номер��6!   $
��Left=�65   $��286,196,0,0q�6P   $	��Top=�6e   $	��113��6}   $��24��6�   $y�Hidden=�6�   �� 5   
   -   5        $ vin_text��5      $
��Left=�6$   $��24��6?   $��399,196,0,0q�6K   $
 Wrap=�6`   $	��Top=�6t   $	��120��6�   $y�Hidden=�6�   �� 5   
   -   5         ��Name$ brands_combo��5      $
��Left=�6)   $��399,138,0,0q�6D   $	��Top=�6Y   $	��120��6q   $y�Hidden=�6}   �� 5   
   -   5        $��
Назад��5      $
��Left=�6!   $��319,374,0,0q�6<   $	��Top=�6Q   $��75��6i   6t   &   System.Windows.Controls.DataGrid  5   
   -   5          Name$
 grid��5      $
��Left=�6!   $	��333��6<   $��	47,36,0,0q�6I   $	��Top=�6\   $	��704��6t   $y�Hidden=�6�   �� 5   
   -	   5         ��Name$ but_new��5      $��Продолжить��6"   $
��Left=�67   $��399,374,0,0q�6R   $	��Top=�6g   $��75��6   6�   �� 5   
   -
   5        $ 	but_exist��5      $��Продолжить��6$   $
��Left=�69   $��399,374,0,0q�6T   $	��Top=�6i   $��75��6�   6�   	� 5   
   -   5        $��Существующий��5      $
��Left=�6-   $��	47,16,0,0q�6H   $	��Top=�6[    d� 	IsChecked$
 TrueY�6s   6�   	� 5   
   -   5        $��
Новый��5      $
��Left=�6&   $��
176,16,0,0q�6A   $	��Top=�6U   6m   5      5      