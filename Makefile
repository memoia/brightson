.PHONY: build run clean

lib/newtonsoft.json:
	mkdir -p $@
	curl -o temp.zip -L "http://download-codeplex.sec.s-msft.com/Download/Release?ProjectName=json&DownloadId=690219&FileTime=130149616152700000&Build=20552"
	unzip -d $@ temp.zip
	rm temp.zip
	ln $@/Bin/Net40/Newtonsoft.Json.dll lib/

main.exe: lib/newtonsoft.json
	dmcs -out:$@ -r:lib/Newtonsoft.Json.dll foo.cs

clean:
	rm -f *.exe

run: main.exe
	MONO_PATH=lib/ mono main.exe

build: clean main.exe run
