all: liboqs-jni KEM_example Sig_example Rand_example

tests: KEMTest SigTest

# Compile JNI code

liboqs-jni:
	$(MAKE) -C src/main/c


# Compile examples

KEM_example: liboqs-jni
	javac -cp src/main/java/ src/examples/java/org/openquantumsafe/KEMExample.java

Sig_example: liboqs-jni
	javac -cp src/main/java/ src/examples/java/org/openquantumsafe/SigExample.java

Rand_example: liboqs-jni
	javac -cp src/main/java/ src/examples/java/org/openquantumsafe/RandExample.java


# Compile Tests

KEMTest: liboqs-jni
	javac -cp lib/junit-4.13.jar:src/main/java src/test/java/org/openquantumsafe/KEMTest.java

SigTest: liboqs-jni
	javac -cp lib/junit-4.13.jar:src/main/java src/test/java/org/openquantumsafe/SigTest.java


# Run examples

run-kem:
	java -Xss10M -cp src/main/java/:src/examples/java/ -Djava.library.path=./src/main/c/ org.openquantumsafe.KEMExample

run-sig:
	java -Xss10M -cp src/main/java/:src/examples/java/ -Djava.library.path=./src/main/c/ org.openquantumsafe.SigExample

run-rand:
	java -cp src/main/java/:src/examples/java/ -Djava.library.path=./src/main/c/ org.openquantumsafe.RandExample


# Run Tests

run-kem-test:
	java -Xss10M -cp lib/junit-4.13.jar:lib/hamcrest-2.2.jar:src/main/java/:src/test/java/ -Djava.library.path=./src/main/c/ org.junit.runner.JUnitCore org.openquantumsafe.KEMTest

run-sig-test:
	java -Xss10M -cp lib/junit-4.13.jar:lib/hamcrest-2.2.jar:src/main/java/:src/test/java/ -Djava.library.path=./src/main/c/ org.junit.runner.JUnitCore org.openquantumsafe.SigTest

run-tests: run-kem-test run-sig-test


# Clean

clean-c:
	$(MAKE) -C src/main/c clean

clean-java:
	$(MAKE) -C src/main/java/org/openquantumsafe clean

clean-tests:
	$(RM) src/test/java/org/openquantumsafe/*.class

clean:
	$(MAKE) -C src/main/c clean
	$(MAKE) -C src/main/java/org/openquantumsafe clean
	$(MAKE) -C src/test/java/org/openquantumsafe clean
	$(MAKE) -C src/examples/java/org/openquantumsafe clean
	$(MAKE) clean-tests
	$(RM) *.log
