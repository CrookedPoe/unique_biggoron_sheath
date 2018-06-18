[VRAM_CODE]:                    0x8001CE60        ; This is the start of code.bin in RAM.
[CODE_PTRS]:                    0x80124E60        ; This is the start of some display list pointers in code.
[SAVE_CONTEXT]:                 0x8015E660        ; Save Context
[SAVE_EQUIPPED]:                0x0068            ; Used to determine currently equipped equipment.
[SAVE_EQUIPPED_EQUIPMENT]:      SAVE_EQUIPPED+0x8

.org 0x800C4708 ; Jump to custom code.
    jal     hack

.org 0x8013C3D0 ; Store some custom variables, in this cases, display list pointers.
ms_sheath:
    .word 0x06015D58
ms_sheath_d:
    .word 0x06015D58
ms_sheath_h:
    .word 0x06021478
ms_sheath_m:
    .word 0x06021478
ms_shsw:
    .word 0x06021400
ms_shsw_d:
    .word 0x06021400
ms_shsw_h:
    .word 0x06021468
ms_shsw_m:
    .word 0x06021488
bs_sheath:
    .word 0x06022698
bs_sheath_d:
    .word 0x06022698
bs_sheath_h:
    .word 0x060228D8
bs_sheath_m:
    .word 0x060228F8
bs_shsw:
    .word 0x060228A0
bs_shsw_d:
    .word 0x060228A0
bs_shsw_h:
    .word 0x060228C8
bs_shsw_m:
    .word 0x060228E8

.align

hack: ; Main Hack Routine
    lbu     t6, 0x0002(a1)
    push    4, t0, t1

    li      t0, @SAVE_CONTEXT
    lhu     t0, @SAVE_EQUIPPED_EQUIPMENT(t0)
    andi    t0, t0, 0x000F                  ; check equipped sword

    beqi    t0, 0x0002, master_sword        ; If Master Sword is equipped, branch to that section
    nop
    beqi    t0, 0x0003, biggoron_sword      ; If Biggoron Sword is equipped, branch to that section
    nop
    b       end                             ; Otherwise, branch to the end.
    nop

master_sword: ; Write Master Sword display list pointers
    li      t0, @CODE_PTRS
    lw      t1, ms_sheath
    sw      t1, 0x0F28(t0)
    sw      t1, 0x0F30(t0)
    sw      t1, 0x1E28(t0)
    sw      t1, 0x1E30(t0)
    lw      t1, ms_sheath_d
    sw      t1, 0x0F38(t0)
    sw      t1, 0x0F40(t0)
    lw      t1, ms_sheath_h
    sw      t1, 0x0F48(t0)
    sw      t1, 0x0F50(t0)
    lw      t1, ms_sheath_m
    sw      t1, 0x0F58(t0)
    sw      t1, 0x0F60(t0)
    lw      t1, ms_shsw
    sw      t1, 0x0EC8(t0)
    sw      t1, 0x0ED0(t0)
    sw      t1, 0x1018(t0)
    sw      t1, 0x1020(t0)
    lw      t1, ms_shsw_d
    sw      t1, 0x0ED8(t0)
    sw      t1, 0x0EE0(t0)
    lw      t1, ms_shsw_h
    sw      t1, 0x0EE8(t0)
    sw      t1, 0x0EF0(t0)
    lw      t1, ms_shsw_m
    sw      t1, 0x0EF8(t0)
    sw      t1, 0x0F00(t0)
    b       end
    nop

biggoron_sword: ; Write Biggoron Sword display list pointers
    li      t0, @CODE_PTRS
    lw      t1, bs_sheath
    sw      t1, 0x0F28(t0)
    sw      t1, 0x0F30(t0)
    sw      t1, 0x1E28(t0)
    sw      t1, 0x1E30(t0)
    lw      t1, bs_sheath_d
    sw      t1, 0x0F38(t0)
    sw      t1, 0x0F40(t0)
    lw      t1, bs_sheath_h
    sw      t1, 0x0F48(t0)
    sw      t1, 0x0F50(t0)
    lw      t1, bs_sheath_m
    sw      t1, 0x0F58(t0)
    sw      t1, 0x0F60(t0)
    lw      t1, bs_shsw
    sw      t1, 0x0EC8(t0)
    sw      t1, 0x0ED0(t0)
    sw      t1, 0x1018(t0)
    sw      t1, 0x1020(t0)
    lw      t1, bs_shsw_d
    sw      t1, 0x0ED8(t0)
    sw      t1, 0x0EE0(t0)
    lw      t1, bs_shsw_h
    sw      t1, 0x0EE8(t0)
    sw      t1, 0x0EF0(t0)
    lw      t1, bs_shsw_m
    sw      t1, 0x0EF8(t0)
    sw      t1, 0x0F00(t0)

end:
    ret     4, t0, t1
