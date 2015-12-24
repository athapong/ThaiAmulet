<%@ page contentType="text/html;charset=UTF-8" pageEncoding="utf-8" language="java" %>
    <table style="vertical-align: top; width: 100%;">
        <tr>
            <td class="menu_left_header" colspan="3" style="text-align: center;">สมัครสมาชิก</td>
        </tr>
        <tr>
            <td class="menu_dot" colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="caption" style="text-align: left;" colspan="3">1. ข้อมูลส่วนตัว</td>
        </tr>

        <tr>
            <td class="caption">ชื่อ นามสกุล<span class="required">*</span></td>
            <td colspan="2">
                <input type="text" class="input_box" id="firstname" name="firstname" maxlength="250" required/>
                &nbsp;
                <input type="text" class="input_box" id="lastname" name="lastname" maxlength="250" required/>
            </td>
        </tr>
        <tr>
            <td class="caption"></td>
            <td class="caption_remark" style="text-align: left;" colspan="2">กรุณากรอกข้อมูลจริงเพื่อประโยชน์ของท่าน</td>
        </tr>
        <tr>
            <td class="caption">เพศ<span class="required">*</span></td>
            <td class="caption_left" colspan="2"><input type="radio" name="sex" value="M" checked/> &nbsp; ชาย&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="sex" value="F"/> &nbsp; หญิง</td>
        </tr>
        <tr>
            <td class="caption">วัน เดือน ปีเกิด<span class="required">*</span></td>
            <td colspan="2"><input type="text" class="input_date_box" id="birthDate" name="birthDate" style="width:150px;" required readonly="true"/>&nbsp;<span class="caption_remark">จำกัดอายุระหว่าง 20-70 ปี</span></td>
        </tr>
        <tr>
            <td class="caption">เลขบัตรประชาชน<span class="required">*</span></td>
            <td colspan="2"><input type="number" class="input_box" id="idCardNo" name="idCardNo" size="15" maxlength="13" required></td>
        </tr>
        <tr>
            <td class="caption">รูปสำเนาบัตรประชาชน<span class="required">*</span></td>
            <td colspan="2">
                <input type="file" class="button_upload" name="btnIdCardUpload" accept="image/*" value="เลือกไฟล์" required>&nbsp;<span class="caption_remark">ขนาดไม่เกิน 300 KB</span>
            </td>
        </tr>
        <tr>
            <td class="caption">รูปสำเนาทะเบียนบ้าน<span class="required">*</span></td>
            <td colspan="2"><input type="file" class="button_upload" name="btnHouseCertUpload" accept="image/*" value="เลือกไฟล์" required>&nbsp;<span class="caption_remark">ขนาดไม่เกิน 300 KB</span></td>
        </tr>
        <tr>
            <td class="caption">เลขอีมี่ (EMEI)/facebook account<span class="required">*</span></td>
            <td colspan="2"><input type="text" class="input_box" id="id4scan" name="id4scan" maxlength="250" required alt="เลชอีมี (EMEI) สำหรับ Android phone หรือ facebook account สำหรับ iPhone">&nbsp;<span class="caption_remark">สำหรับถ่ายภาพใช้ในโปรแกรม ค้นหาพระเครื่อง</span></td>
        </tr>
        <tr>
            <td class="caption">เบอร์โทรศัพท์มือถือ<span class="required">*</span></td>
            <td colspan="2"><input type="number" class="input_box" id="mobileNo" name="mobileNo" maxlength="250" required>&nbsp;<span class="caption_remark">สำหรับใช้ในการติดต่อ</span></td>
        </tr>
        <tr>
            <td class="caption">อีเมล์<span class="required">*</span></td>
            <td><input type="email" class="input_box" id="email" name="email" maxlength="250" required/></td>
            <td class="caption">&nbsp;</td>
        </tr>
        <tr>
            <td class="caption">ยืนยันอีเมล์<span class="required">*</span></td>
            <td><input type="email" class="input_box" id="confirmEmail" name="confirmEmail" maxlength="250" disabled required/></td>
            <td class="caption">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td class="menu_dot" colspan="3">&nbsp;</td>
        </tr>

        <tr>
            <td class="caption" style="text-align: left;" colspan="3">2. กำหนด username และ password</td>
        </tr>
        <tr>
            <td class="caption">username<span class="required">*</span></td>
            <td><input type="text" class="input_box" id="username" name="username" maxlength="25" required/></td>
            <td class="caption"></td>
        </tr>
        <tr>
            <td class="caption">&nbsp;</td>
            <td class="caption_remark">ชื่อ username ความยาวไม่เกิน 25 ตัวอักษร และไม่เว้นวรรค หรือตัวอักขระพิเศษ</td>
            <td class="caption"></td>
        </tr>
        <tr>
            <td class="caption">password<span class="required">*</span></td>
            <td><input type="password" class="input_box" id="password" name="password" maxlength="10" required/></td>
            <td class="caption"></td>
        </tr>
        <tr>
            <td class="caption">ยืนยัน password<span class="required">*</span></td>
            <td colspan="2">
                <input type="password" class="input_box" id="confirmPassword" maxlength="10" disabled required/>&nbsp;&nbsp;
                <span class="small_link">แนะนำการตั้ง password</span>
            </td>
        </tr>
        <tr>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><input type="button" id="registerBtn" class="button" value="     สมัครสมาชิก     " onclick="checkBirthDate()">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" class="button" value="     ยกเลิก     " onclick="window.open('index','_self')"></td>
            <td>&nbsp;</td>
        </tr>
    </table>
