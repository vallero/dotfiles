// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) lnc 
// Source File Name:   SyntheticAttribute.java

package javassist.bytecode;

import java.io.DataInputStream;
import java.io.IOException;
import java.util.Map;

// Referenced classes of package javassist.bytecode:
//            AttributeInfo, ConstPool

public class SyntheticAttribute extends AttributeInfo
{

            SyntheticAttribute(ConstPool constpool, int i, DataInputStream datainputstream)
                throws IOException
            {
/*  35*/        super(constpool, i, datainputstream);
            }

            public SyntheticAttribute(ConstPool constpool)
            {
/*  44*/        super(constpool, "Synthetic", new byte[0]);
            }

            public AttributeInfo copy(ConstPool constpool, Map map)
            {
/*  54*/        return new SyntheticAttribute(constpool);
            }

            public static final String tag = "Synthetic";
}
