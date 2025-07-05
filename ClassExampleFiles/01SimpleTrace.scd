//: 土  5  7 2025 08:38
//:Post changes
1.simpleTrace;
10 do: { | i | 1.changed(i) };
//:stop posting changes
1.simpleUntrace;
10 do: { | i | 1.changed(i) };