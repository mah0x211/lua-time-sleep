TARGET=src/nanosleep.$(LIB_EXTENSION)
SRCS=$(wildcard src/*.c)
OBJS=$(SRCS:.c=.$(LIB_EXTENSION))
GCDAS=$(OBJS:.so=.gcda)
INSTALL?=install

ifdef NANOSLEEP_COVERAGE
COVFLAGS=--coverage
endif

.PHONY: all install

all: $(OBJS)

%.o: %.c
	$(CC) $(CFLAGS) $(WARNINGS) $(COVFLAGS) $(CPPFLAGS) -o $@ -c $<

%.$(LIB_EXTENSION): %.o
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS) $(PLATFORM_LDFLAGS) $(COVFLAGS)

install: $(OBJS)
	$(INSTALL) -d $(INST_LIBDIR)/nanosleep
	$(INSTALL) $(TARGET) $(INST_LIBDIR)
	$(INSTALL) $(filter-out $(TARGET), $(OBJS)) $(INST_LIBDIR)/nanosleep
	rm -f ./src/*.o
	rm -f ./src/*.$(LIB_EXTENSION)

