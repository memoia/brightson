.PHONY: build run clean test

lib/nunit:
	rm -rf $@
	curl -o temp.zip -L "http://launchpad.net/nunitv2/2.6.2/2.6.2/+download/NUnit-2.6.2.zip"
	unzip temp.zip
	mv NUnit-2.6.2 lib/nunit
	rm temp.zip
	ln $@/bin/nunit.framework.dll lib/

lib/newtonsoft.json:
	mkdir -p $@
	curl -o temp.zip -L "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=json&DownloadId=690219&FileTime=130149616152700000&Build=20552"
	unzip -d $@ temp.zip
	rm temp.zip
	ln $@/Bin/Net40/Newtonsoft.Json.dll lib/

main.exe: lib/newtonsoft.json
	dmcs -out:$@ -r:lib/Newtonsoft.Json.dll foo.cs

clean:
	rm -f *.exe *.dll TestResult.xml

run: main.exe
	MONO_PATH=lib/ mono main.exe

test_foo.dll:
	dmcs -out:$@ -target:library -r:lib/Newtonsoft.Json.dll,lib/nunit.framework.dll test_foo.cs foo.cs

test: test_foo.dll
	MONO_PATH=lib/ nunit-console test_*.dll

build: clean main.exe run
