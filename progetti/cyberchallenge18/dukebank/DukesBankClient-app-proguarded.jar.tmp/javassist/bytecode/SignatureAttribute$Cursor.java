// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) lnc 
// Source File Name:   SignatureAttribute.java

package javassist.bytecode;


// Referenced classes of package javassist.bytecode:
//            BadBytecode, SignatureAttribute

static class <init>
{

            int indexOf(String s, int i)
                throws BadBytecode
            {
/* 164*/        if((i = s.indexOf(i, position)) < 0)
                {
/* 166*/            throw SignatureAttribute.access$000(s);
                } else
                {
/* 168*/            position = i + 1;
/* 169*/            return i;
                }
            }

            int position;

            private ()
            {
/* 161*/        position = 0;
            }

            position(position position1)
            {
/* 160*/        this();
            }
}
