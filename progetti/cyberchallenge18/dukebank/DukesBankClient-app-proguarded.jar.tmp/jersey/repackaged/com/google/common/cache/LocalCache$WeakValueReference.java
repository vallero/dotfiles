// Decompiled by Jad v1.5.8e. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.geocities.com/kpdus/jad.html
// Decompiler options: packimports(3) lnc 
// Source File Name:   LocalCache.java

package jersey.repackaged.com.google.common.cache;

import java.lang.ref.ReferenceQueue;
import java.lang.ref.WeakReference;

// Referenced classes of package jersey.repackaged.com.google.common.cache:
//            LocalCache

static class entry extends WeakReference
    implements entry
{

            public int getWeight()
            {
/*1589*/        return 1;
            }

            public entry getEntry()
            {
/*1594*/        return entry;
            }

            public void notifyNewValue(Object obj)
            {
            }

            public entry copyFor(ReferenceQueue referencequeue, Object obj, entry entry1)
            {
/*1603*/        return new <init>(referencequeue, obj, entry1);
            }

            public boolean isLoading()
            {
/*1608*/        return false;
            }

            public boolean isActive()
            {
/*1613*/        return true;
            }

            public Object waitForValue()
            {
/*1618*/        return get();
            }

            final get entry;

            (ReferenceQueue referencequeue, Object obj,  )
            {
/*1583*/        super(obj, referencequeue);
/*1584*/        entry = ;
            }
}
