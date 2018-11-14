use thuvien;
DELIMITER $$

DROP Procedure if Exists `layThongTinSach`;

CREATE PROCEDURE 
  layThongTinSach( ID char(5) )
BEGIN  
   SELECT * FROM sach
    WHERE MASACH=ID
    ;
   
END;

call layThongTinSach('0002')


DROP Procedure if Exists `TiepNhanSach`;
DELIMITER $$
CREATE PROCEDURE 
  TiepNhanSach(IN p_MASACH char(5),IN  p_TENSACH varchar(50),
  IN p_THELOAI varchar(30),IN p_TACGIA varchar(40),
  IN p_NAMXB int ,IN p_NHAXB varchar(40),
  IN p_TRIGIA float,IN p_NGAYNHAP date,IN p_NGUOINHAP char(5)	)
BEGIN  
   insert into SACH (MASACH,TENSACH,THELOAI,TACGIA,NAMXB,NHAXB,TRIGIA,NGAYNHAP,NGUOINHAP)
   values (p_MASACH,p_TENSACH,p_THELOAI,p_TACGIA,p_NAMXB,p_NHAXB,p_TRIGIA,p_NGAYNHAP,p_NGUOINHAP);
END$$

call TiepNhanSach('0012','ABC','BCD','Nguyen Van A','2032','qwe',1234.5,'2012-02-08','0007');

DELIMITER $$
DROP Procedure if Exists `ThanhLySach`;

CREATE PROCEDURE 
  ThanhLySach( IN p_MASACH char(5) )
BEGIN  
	DELETE FROM sach
	WHERE sach.MASACH=p_MASACH;
END;
call ThanhLySach('0011');

SELECT * FROM thuvien.sach;
