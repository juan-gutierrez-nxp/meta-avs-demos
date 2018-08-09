all: libcjson.so 

libcjson.so: cJSON.c cJSON.h
	$(CC) -shared -fPIC $(CFLAGS) $(CPPFLAGS) -o $@ $<

clean:
	rm -f libcjson.so
	rm -f cJSON.h

